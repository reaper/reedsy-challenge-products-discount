class ProductSerializer < ActiveModel::Serializer
  attributes :code, :name, :price_cents, :price

  def price
    object.price.format(format: '%n%u')
  end
end
