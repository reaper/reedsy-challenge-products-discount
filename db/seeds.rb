# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

[
  { code: 'MUG', name: 'Reedsy Mug', price_cents: 600 },
  { code: 'TSHIRT', name: 'Reedsy T-shirt', price_cents: 1500 },
  { code: 'HOODIE', name: 'Reedsy Hoodie', price_cents: 2000 }
].each do |data|
  product = Product.find_or_initialize_by(data)
  puts "Created product #{product.inspect}".green if product.new_record? && product.save
end
