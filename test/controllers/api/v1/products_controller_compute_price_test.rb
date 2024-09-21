require 'test_helper'

class Api::V1::ProductsControllerComputePriceTest < ActionDispatch::IntegrationTest
  setup do
    10.times.each do
      create(:product)
    end
  end

  test 'fails to compute price with bad product id' do
    get compute_price_api_v1_products_url(codes: ['BAAAAAAAD']), as: :json
    assert_response :not_found
  end

  test 'should be able to compute the price of selected products' do
    products = 5.times.map { Product.all.sample }
    get compute_price_api_v1_products_url(codes: products.map(&:code)), as: :json
    assert_response :success

    body = JSON.parse(response.body)
    %w[codes_with_count price_cents price].each do |attr|
      assert(body.key?(attr))
    end

    assert(products.all? { |product| body['codes_with_count'].keys.include?(product.code) })
    assert_equal(body['price_cents'], products.map(&:price_cents).sum)
  end

  test 'should be able to compute the price with discount 2 for 1' do
    product = Product.first
    product.apply_discount(:'2_for_1')
    product_codes = 5.times.map { product.code }

    get compute_price_api_v1_products_url(codes: product_codes), as: :json
    assert_response :success

    body = JSON.parse(response.body)
    assert_equal(body['price_cents'], product.price_cents * 4)
  end

  test 'should be able to compute the price with discount 30% when buying 3 or more' do
    product = Product.first
    product.apply_discount(:percentage, { amount: 0.3, buy_at_least: 3 })
    product_codes = 5.times.map { product.code }

    get compute_price_api_v1_products_url(codes: product_codes), as: :json
    assert_response :success

    body = JSON.parse(response.body)
    assert_equal(body['price_cents'], ((product.price_cents * 5) * 0.7).round)
  end
end
