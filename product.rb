require_relative 'd_b_adapter'
# This class handles the data related product
# i.e product name, price, description, categpry

class Product < DBAdapter
  @@table_name = 'products'
  attr_reader :attrs

  # def initialize(name, price, description, category_id)
  #   @name, @price, @description, @category_id = name, price, description, category_id
  # end

  def initialize(attrs = {})
    @attrs = attrs
  end

  def save
    if valid_data
      super
    end
  end

  def valid_data
    if attrs['price'].to_i < 0
      puts 'Price should be greater than 0'
      return false
    end
    %w[name price description category_id].each do |field|
      if attrs[field] == '' || attrs[field].nil?
        puts "can not add product with empty #{field}"
        return false
      end
    end
  end

  def self.display_all
    rs = all
    print_collection(rs)
  end
end
