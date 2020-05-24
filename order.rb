require_relative 'd_b_adapter'
require_relative 'order_manager'

# This class handles the data related order
# i.e user_info, oder amount, discount details
class Order < DBAdapter
  @@table_name = 'orders'
  attr_accessor :attrs

  def initialize(attrs = {})
    @attrs = attrs
    if @attrs['status'].nil?
      @attrs['status'] = 'cart'
    end
  end

  def audit
    OrderManager.new(self).recalculate
  end

  def complete
    attrs['status'] = 'completed'
    save
  end

  def self.current_order
    Order.where("status = 'cart' ").last
  end
end
