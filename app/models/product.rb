class Product < ApplicationRecord
  monetize :price_cents

  validates :code, uniqueness: true, presence: true
  validates :name, presence: true
  validates :price_cents, presence: true

  def apply_discount(discount_key, _options = {})
    return unless discount_key

    discount_hash = {}
    case discount_key.to_sym
    when :'2_for_1' then discount_hash[discount_key] = true
    when :percentage
      raise 'no_amount' unless _options.key?(:amount)
      raise 'no_buy_at_least' unless _options.key?(:buy_at_least)

      discount_hash[discount_key] = _options
    end

    update(discount: discount.merge(discount_hash))
  end
end
