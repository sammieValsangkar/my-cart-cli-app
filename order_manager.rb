require_relative 'line_item'
DISCOUNTABLE_AMOUNT = 10000.freeze
DISCOUNT = 500.freeze

# This class manages operation related to Order.
class OrderManager
  attr_reader :order

  def initialize(order)
    @order = order
  end

  # to recalcute order total amount and apply/remove discount as per conditions
  def recalculate
    line_items = LineItem.where("order_id = '#{order.attrs['id']}'")
    sub_total = 0
    line_items.map do |li|
     sub_total +=  li.attrs['amount'].to_f * li.attrs['quantity'].to_i
    end
    order.attrs = order.attrs.merge('sub_total' => sub_total)
    if sub_total > DISCOUNTABLE_AMOUNT
      @order.attrs = order.attrs.merge('amount' => sub_total - DISCOUNT, 'discont_desc' => "#{DISCOUNT} OFF For order more than #{DISCOUNTABLE_AMOUNT}")
    else
      @order.attrs = order.attrs.merge('amount' => sub_total, 'discont_desc' => '')
    end

    @order.save

  end

  # order print logic is here, can be moved to somewhere else
  def print_order
    p "@@@@@@@@@ Order id: ##{order.attrs['id']}"
    p "Name: #{order.attrs['name']}  Email: #{order.attrs['email']}"
    p "Status: #{order.attrs['status']}"

    conn = DatabaseConnector.new.connect
    rs = conn.exec "select li.*, products.name from line_items as li  INNER JOIN products on li.product_id = products.id where li.order_id = '#{order.attrs['id']}'"

    char_len = 30
    rs.each do |row|
      prod_name = "#{row['id']} : #{row['name']}"

      p "#{prod_name} #{'-'*(char_len - prod_name.length)}---> #{row['amount']} X #{row['quantity']} = #{row['amount'].to_f * row['quantity'].to_i}"
    end
    p '-'*55
    if order.attrs['discont_desc'] != ''
      p "Sub Total #{'-'*25} -> #{order.attrs['sub_total']}"
      p "Coupon #{'-'*25} -> #{order.attrs['discont_desc']}"
      p "You Saved #{'-'*25} -> #{order.attrs['amount'].to_i - order.attrs['sub_total'].to_i}"
    p '-'*55
    end
    p "Total #{'-'*25} -> #{order.attrs['amount']}"
  end

end