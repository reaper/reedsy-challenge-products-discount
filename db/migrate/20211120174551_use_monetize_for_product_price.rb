class UseMonetizeForProductPrice < ActiveRecord::Migration[6.1]
  def change
    remove_column :products, :price
    add_monetize :products, :price
  end
end
