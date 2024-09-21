# entity3 CHALLENGE

Welcome to the entity3 challenge.
I hope you will enjoy reading it and will be satisfied of what have been done.

A project has been created to handle the tasks to do for this challenge. It is available at https://github.com/reaper/entity3-challenge/projects/1.
Fee free to see the commits to be aware of the resolution steps https://github.com/reaper/entity3-challenge/commits/main.

## Dependencies

- active_model_serializers

It has been used to serialize products without having unwanted exposed attributes and make some helpers, to expose formatted price, for example.

- money-rails

Used to process products money and having great wrappers, and storing well formatted data in the database to be able to apply transactions without blowing our mind.

- httparty

Principally used to run the challenge rake task to do some http requests on the running localhost server.

- apipie-rails

Used to generate the API endpoints documentation

- factory_bot_rails

Test library usefull to create entries when running tests. In the challenge case I required it to create unique product codes.

- faker

Always using it to create fake data.

## Starting
### 1. How to setup

Install ruby version 2.7.4 (using rvm)
```
rvm install 2.7.4
rvm use 2.7.4
```

Checkout the entity3 challenge repository
```
git clone git@github.com:reaper/entity3-challenge.git
cd entity3-challenge
```

Installing gems with bundler
```
bundle install
```

Preparing and seeding db, considering for the challenge using sqlite db
```
rake db:prepare db:seed
```

Starting your server
```
rails s # or server
```

### 2. Running tests

Some tests have been written to ensure that api endpoints are following the wanted specs.
They are available in the /test folder, and particulary in /test/controllers/api/v1.

To run them, feel free to run the command
```
rails test
```

### 3. Documentation

The documentation has been generated with apipie-rails (https://github.com/Apipie/apipie-rails).
It is accessible at https://reaper.github.io/entity3-challenge, but also in the docs folder.

## Answering to challenge questions

After having running the ```rails server``` command to run your server, please run the rake task in another terminal
```
rake challenge:run
```

The output should be like
```
==============================
> Question 1
  Implement an API endpoint that allows listing the existing items in the store, as well as their attributes.

Calling url http://localhost:3000/api/v1/products
[{"code":"MUG","name":"entity3 Mug","price_cents":600,"price":"6.00€"},{"code":"TSHIRT","name":"entity3 T-shirt","price_cents":1500,"price":"15.00€"},{"code":"HOODIE","name":"entity3 Hoodie","price_cents":2000,"price":"20.00€"}]
Found product with atributes {"code"=>"MUG", "name"=>"entity3 Mug", "price_cents"=>600, "price"=>"6.00€"}
Found product with atributes {"code"=>"TSHIRT", "name"=>"entity3 T-shirt", "price_cents"=>1500, "price"=>"15.00€"}
Found product with atributes {"code"=>"HOODIE", "name"=>"entity3 Hoodie", "price_cents"=>2000, "price"=>"20.00€"}


==============================
> Question 2
  Implement an API endpoint that allows updating the price of a given product.

Updating product HOODIE
Current price is 20.00€
Calling url http://localhost:3000/api/v1/products/HOODIE
{"code":"HOODIE","name":"entity3 Hoodie","price_cents":10000,"price":"100.00€"}
Updated product successfully
New price is 100.00€!
Restoring original price
Calling url http://localhost:3000/api/v1/products/HOODIE
{"code":"HOODIE","name":"entity3 Hoodie","price_cents":2000,"price":"20.00€"}
Restored product price successfully (20.00€)


==============================
> Question 3
  Implement an API endpoint that allows one to check the price of a given list of items.

Calling url http://localhost:3000/api/v1/products/compute_price
{"codes_with_count":{"MUG":1,"TSHIRT":1,"HOODIE":1},"price_cents":4100,"price":"41.00€"}
ITEMS: MUG, TSHIRT, HOODIE
TOTAL: 41.00€

Calling url http://localhost:3000/api/v1/products/compute_price
{"codes_with_count":{"MUG":2,"TSHIRT":1},"price_cents":2100,"price":"21.00€"}
ITEMS: MUG, TSHIRT
TOTAL: 21.00€

Calling url http://localhost:3000/api/v1/products/compute_price
{"codes_with_count":{"MUG":3,"TSHIRT":1},"price_cents":2700,"price":"27.00€"}
ITEMS: MUG, TSHIRT
TOTAL: 27.00€

Calling url http://localhost:3000/api/v1/products/compute_price
{"codes_with_count":{"MUG":2,"TSHIRT":4,"HOODIE":1},"price_cents":6800.0,"price":"68.00€"}
ITEMS: MUG, TSHIRT, HOODIE
TOTAL: 68.00€


==============================
> Question 4
  We'd like to expand our store to provide some discounted prices in some situations.

Calling url http://localhost:3000/api/v1/products/compute_price
{"codes_with_count":{"MUG":1,"TSHIRT":1,"HOODIE":1},"price_cents":4100,"price":"41.00€"}
ITEMS: MUG, TSHIRT, HOODIE
TOTAL: 41.00€

Calling url http://localhost:3000/api/v1/products/compute_price
{"codes_with_count":{"MUG":2,"TSHIRT":1},"price_cents":2100,"price":"21.00€"}
ITEMS: MUG, TSHIRT
TOTAL: 21.00€

Calling url http://localhost:3000/api/v1/products/compute_price
{"codes_with_count":{"MUG":3,"TSHIRT":1},"price_cents":2700,"price":"27.00€"}
ITEMS: MUG, TSHIRT
TOTAL: 27.00€

Calling url http://localhost:3000/api/v1/products/compute_price
{"codes_with_count":{"MUG":4,"TSHIRT":1},"price_cents":3300,"price":"33.00€"}
ITEMS: MUG, TSHIRT
TOTAL: 33.00€

Calling url http://localhost:3000/api/v1/products/compute_price
{"codes_with_count":{"MUG":2,"TSHIRT":4,"HOODIE":1},"price_cents":6800.0,"price":"68.00€"}
ITEMS: MUG, TSHIRT, HOODIE
TOTAL: 68.00€
```
