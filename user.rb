# User related activities handled here
class User
  def create_cart
    if current_order
      p "You already have created a cart. :)"
    else
      data = UserInteraction.get_user_details
      order = Order.new(data)
      order.save
    end
  end

  def category_list
    Category.display_all
  end

  def list_product_from_category
    category_id = UserInteraction.get_category_id
    coll = Product.where("category_id = '#{category_id}'")
    Product.print_collection(coll)
  end

  def add_to_cart
    create_cart unless current_order
    current_order

    data = UserInteraction.add_to_cart_details

    product = Product.find_by_id(data['product_id'])

    if product.nil?
      p 'Product not found'
    else
      prod_price = product.attrs['price']

      li = LineItem.new(data.merge('order_id' => current_order.attrs['id'], 'amount' => prod_price))
      li.save
    end
    show_order
  end

  def remove_from_cart
    if current_order
      product_id = UserInteraction.get_product_id
      order_id = current_order.attrs['id']
      LineItem.delete_where("product_id = '#{product_id}' and order_id = '#{order_id}'")
      current_order.audit
      show_order
    else
      p "You dont have any items in cart"
    end
  end

  def print_all_orders
    Order.all.each do |order|
      p '@'*65
      OrderManager.new(order).print_order
      p '@'*65
    end
  end

  def complete_order
    order = current_order
    current_order.complete
    puts "Thank you for ordering from us. :)"
    # show_order
    OrderManager.new(order).print_order
  end

  private

  def show_order
    OrderManager.new(current_order).print_order
  end

  def current_order
    Order.current_order
  end
end