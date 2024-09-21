class AddDiscountToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :discount, :jsonb, default: {}, null: false
  end
end
