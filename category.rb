require_relative 'd_b_adapter'
# This class handles the category info
# i.e category name
class Category < DBAdapter
  @@table_name = 'categories'
  attr_reader :attrs

  # def initialize(name, price, description, category_id)
  #   @name, @price, @description, @category_id = name, price, description, category_id
  # end

  def initialize(attrs = {})
    @attrs = attrs
  end

  def self.display_all
    rs = all
    print_collection(rs)
  end

  def save
    if valid_data
      super
    end
  end

  private

  def valid_data
    %w[name ].each do |field|
      if attrs[field] == '' || attrs[field].nil?
        puts "can not add category with empty #{field}"
        return false
      end
    end
  end
end
