class ProductsPrice < ActiveModelSerializers::Model
  attributes :codes_with_count, :price_cents
end
