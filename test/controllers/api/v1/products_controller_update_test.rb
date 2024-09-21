require 'test_helper'

class Api::V1::ProductsControllerUpdateTest < ActionDispatch::IntegrationTest
  setup do
    @product = create(:product)
  end

  test 'success to update product' do
    patch api_v1_product_url(@product.code), params: { product: { price_cents: 3000 } }, as: :json
    assert_response 200
  end

  test 'should update product and return set data' do
    old_price = @product.price.format
    price_cents = 3000

    patch api_v1_product_url(@product.code), params: { product: { price_cents: price_cents } }, as: :json
    body = JSON.parse(response.body)

    assert_not_equal(body['price'], old_price)
    assert_equal(body['price'], Money.from_cents(price_cents, 'EUR').format(format: "%n%u"))
  end
end
