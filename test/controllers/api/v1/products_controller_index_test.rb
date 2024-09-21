require 'test_helper'

class Api::V1::ProductsControllerIndexTest < ActionDispatch::IntegrationTest
  setup do
    10.times.each do
      create(:product)
    end
  end

  test 'should get index' do
    get api_v1_products_url, as: :json
    assert_response :success
  end

  test 'should get 10 products' do
    get api_v1_products_url, as: :json
    body = JSON.parse(response.body)
    assert(body.class, Array)
    assert_equal(body.size, 10)
  end

  test 'should show product with attributes' do
    get api_v1_products_url, as: :json
    body = JSON.parse(response.body)

    body.each do |product|
      %w[code name price].each do |attr|
        assert_not_empty(product[attr])
      end
    end
  end
end
