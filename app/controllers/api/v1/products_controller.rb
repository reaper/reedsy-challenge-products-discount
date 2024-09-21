class Api::V1::ProductsController < ApplicationController
  before_action :set_product, only: %i[show update]

  # GET /api/v1/products
  #
  api :GET, '/api/v1/products'
  description 'Get the products list with attributes'
  returns code: 200, desc: 'Products as JSON array' do
    property :array, Array, desc: 'An array of product' do
      property :product, Product, desc: 'Product JSON'
    end
  end
  def index
    @products = Product.all
    render json: @products
  end

  # GET /api/v1/products/code
  #
  api :GET, '/api/v1/products/:id'
  description 'Get a product attributes'
  param :id, String, desc: 'code of the product', required: true
  returns code: 200, desc: 'Product as JSON' do
    property :product, Product, desc: 'Product JSON'
  end
  returns code: 404, desc: 'No product found' do
    property :error, String, desc: 'No product found'
  end
  def show
    render json: @product
  end

  # PATCH/PUT /api/v1/products/code
  #
  api :PUT, '/api/v1/products'
  description 'Update a product and return its attributes'
  param :id, String, desc: 'code of the product', required: true
  returns code: 200, desc: 'Product as JSON' do
    property :product, Product, desc: 'Product JSON'
  end
  returns code: 422, desc: 'Product errors' do
    property :errors, Hash, desc: 'Hash of product errors'
  end
  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # GET /api/v1/products/compute_price
  #
  api :GET, '/api/v1/products/compute_price'
  description 'Compute the price of selected products'
  param :codes, Array, desc: 'products codes to compute price', required: true
  returns code: 200, desc: 'Products price as JSON' do
    property :codes_with_count, Hash, desc: 'Products code with count'
    property :price_cents, Integer, desc: 'Selected products price in cents'
    property :price, String, desc: 'Selected products price'
  end
  returns code: 400, desc: 'No products code' do
    property :error, String, desc: 'No products code error'
  end
  returns code: 404, desc: 'No product found' do
    property :error, String, desc: 'No product found'
  end
  def compute_price
    unless params[:codes].present?
      render json: :no_product_codes, status: :bad_request
      return
    end

    begin
      codes_with_count = params[:codes].tally
      price_cents = codes_with_count.sum do |code, count|
        product = Product.find_by!(code: code)
        products_count = count
        product_price_cents = product.price_cents

        # apply discounts
        if product.discount.present?
          product.discount.each do |key, options|
            case key
            when '2_for_1'
              products_count -= 1 if count >= 2
            when 'percentage'
              product_price_cents *= (1 - options['amount']) if count >= options['buy_at_least']
            end
          end
        end

        (product_price_cents * products_count).round
      end
    rescue ActiveRecord::RecordNotFound
      render json: :product_not_found, status: :not_found
      return
    end

    # use products price serializer
    products_price = ProductsPrice.new(
      codes_with_count: codes_with_count,
      price_cents: price_cents
    )

    render json: products_price
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find_by!(code: params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(
      :price_cents
    )
  end
end
