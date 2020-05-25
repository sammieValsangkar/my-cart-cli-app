# my-cart-cli-app
shopping cart cli application

#Requirements
 - postgresql
 - ruby
 - gem pg
 - gem rspec


#Steps to run app
1. create database `my_cart` in postgres user. if you have different configuration update `database_connector.rb`
2. import app.sql file into that using `psql mycart < app.sql`
3. run store.rb
4. to run test cases, run `rspec`
