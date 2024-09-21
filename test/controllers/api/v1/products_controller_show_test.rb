require 'test_helper'

class Api::V1::ProductsControllerShowTest < ActionDispatch::IntegrationTest
  setup do
    @product = create(:product)
  end

  test 'should show product' do
    get api_v1_product_url(@product.code), as: :json
    assert_response :success
  end

  test 'should show product with attributes' do
    get api_v1_product_url(@product.code), as: :json
    body = JSON.parse(response.body)

    %w[code name price].each do |attr|
      assert_not_empty(body[attr])
    end
  end

  test 'should show product without created and updated at' do
    get api_v1_product_url(@product.code), as: :json
    body = JSON.parse(response.body)

    %w[created_at updated_at].each do |attr|
      assert_nil(body[attr])
    end
  end

  test 'should show product with formatted price' do
    get api_v1_product_url(@product.code), as: :json
    body = JSON.parse(response.body)
    assert_includes(body['price'], '€')
  end
end
