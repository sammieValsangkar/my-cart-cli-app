require_relative 'd_b_adapter'
# This class holds the info about purchased product
# i.e product id, price, quantity, order_id
class LineItem < DBAdapter
  @@table_name = 'line_items'
  attr_reader :attrs

  def initialize(attrs = {})
    @attrs = attrs
  end

  def save
    if valid_data
      super
      update_order
    end
  end

  private

  def valid_data
    if attrs['quantity'].to_i < 0
      puts 'Price should be minimum 1'
      return false
    end
    %w[product_id quantity order_id amount ].each do |field|
      if attrs[field] == '' || attrs[field].nil?
        puts "can not create line item with empty #{field}"
        return false
      end
    end
  end

  def update_order
    order = Order.find_by_id(attrs['order_id'])
    order.audit
  end
end
