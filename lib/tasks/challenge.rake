namespace :challenge do
  desc 'Run the entity3 challenge'
  task run: :environment do
    puts "\n\n==============================".green
    puts "> Question 1".green
    puts "  Implement an API endpoint that allows listing the existing items in the store, as well as their attributes.\n\n"

    url = 'http://localhost:3000/api/v1/products'
    puts "Calling url #{url}"
    response = HTTParty.get(url)
    puts response.body.yellow
    products = JSON.parse(response.body)
    products.each do |product|
      puts "Found product with atributes #{product.inspect}".cyan
    end

    puts "\n\n==============================".green
    puts "> Question 2".green
    puts "  Implement an API endpoint that allows updating the price of a given product.\n\n"

    product_to_update = products.last.with_indifferent_access
    original_price_cents = product_to_update[:price_cents]
    price_cents = 1000_0

    puts "Updating product #{product_to_update[:code]}"
    puts "Current price is #{product_to_update[:price]}"

    url = "http://localhost:3000/api/v1/products/#{product_to_update[:code]}"
    puts "Calling url #{url}"

    response = HTTParty.patch(url,
                              body: { product: { price_cents: price_cents } })
    puts response.body.yellow
    product_json = JSON.parse(response.body).with_indifferent_access

    if response.ok?
      puts "Updated product successfully"
      puts "New price is #{product_json[:price]}!".cyan

      puts "Restoring original price"
      puts "Calling url #{url}"
      response = HTTParty.patch(url, body: { product: { price_cents: original_price_cents }})
      puts response.body.yellow
      product_json = JSON.parse(response.body).with_indifferent_access

      puts "Restored product price successfully (#{product_json[:price]})".cyan if response.ok?
    end

    puts "\n\n==============================".green
    puts "> Question 3".green
    puts "  Implement an API endpoint that allows one to check the price of a given list of items.\n\n"

    url = 'http://localhost:3000/api/v1/products/compute_price'
    puts "Calling url #{url}"
    response = HTTParty.get(url, query: { codes: ['MUG', 'TSHIRT', 'HOODIE'] })
    puts response.body.yellow
    result = JSON.parse(response.body).with_indifferent_access

    puts "ITEMS: #{result[:codes_with_count].keys.join(', ')}"
    puts "TOTAL: #{result[:price]}"

    puts "\nCalling url #{url}"
    response = HTTParty.get(url, query: { codes: ['MUG', 'TSHIRT', 'MUG'] })
    puts response.body.yellow
    result = JSON.parse(response.body).with_indifferent_access

    puts "ITEMS: #{result[:codes_with_count].keys.join(', ')}"
    puts "TOTAL: #{result[:price]}"

    puts "\nCalling url #{url}"
    response = HTTParty.get(url, query: { codes: ['MUG', 'TSHIRT', 'MUG', 'MUG'] })
    puts response.body.yellow
    result = JSON.parse(response.body).with_indifferent_access

    puts "ITEMS: #{result[:codes_with_count].keys.join(', ')}"
    puts "TOTAL: #{result[:price]}"

    puts "\nCalling url #{url}"
    response = HTTParty.get(url, query: { codes: ['MUG', 'TSHIRT', 'TSHIRT', 'TSHIRT', 'TSHIRT', 'MUG', 'HOODIE'] })
    puts response.body.yellow
    result = JSON.parse(response.body).with_indifferent_access

    puts "ITEMS: #{result[:codes_with_count].keys.join(', ')}"
    puts "TOTAL: #{result[:price]}"

    puts "\n\n==============================".green
    puts "> Question 4".green
    puts "  We'd like to expand our store to provide some discounted prices in some situations.\n\n"

    Product.find_by!(code: 'MUG').apply_discount(:'2_for_1')
    Product.find_by!(code: 'TSHIRT').apply_discount(:percentage, { amount: 0.3, buy_at_least: 3 })

    url = 'http://localhost:3000/api/v1/products/compute_price'
    puts "Calling url #{url}"
    response = HTTParty.get(url, query: { codes: ['MUG', 'TSHIRT', 'HOODIE'] })
    puts response.body.yellow
    result = JSON.parse(response.body).with_indifferent_access

    puts "ITEMS: #{result[:codes_with_count].keys.join(', ')}"
    puts "TOTAL: #{result[:price]}"

    puts "\nCalling url #{url}"
    response = HTTParty.get(url, query: { codes: ['MUG', 'TSHIRT', 'MUG'] })
    puts response.body.yellow
    result = JSON.parse(response.body).with_indifferent_access

    puts "ITEMS: #{result[:codes_with_count].keys.join(', ')}"
    puts "TOTAL: #{result[:price]}"

    puts "\nCalling url #{url}"
    response = HTTParty.get(url, query: { codes: ['MUG', 'TSHIRT', 'MUG', 'MUG'] })
    puts response.body.yellow
    result = JSON.parse(response.body).with_indifferent_access

    puts "ITEMS: #{result[:codes_with_count].keys.join(', ')}"
    puts "TOTAL: #{result[:price]}"

    puts "\nCalling url #{url}"
    response = HTTParty.get(url, query: { codes: ['MUG', 'TSHIRT', 'MUG', 'MUG', 'MUG'] })
    puts response.body.yellow
    result = JSON.parse(response.body).with_indifferent_access

    puts "ITEMS: #{result[:codes_with_count].keys.join(', ')}"
    puts "TOTAL: #{result[:price]}"

    puts "\nCalling url #{url}"
    response = HTTParty.get(url, query: { codes: ['MUG', 'TSHIRT', 'TSHIRT', 'TSHIRT', 'TSHIRT', 'MUG', 'HOODIE'] })
    puts response.body.yellow
    result = JSON.parse(response.body).with_indifferent_access

    puts "ITEMS: #{result[:codes_with_count].keys.join(', ')}"
    puts "TOTAL: #{result[:price]}"
  end
end
