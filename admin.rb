require_relative "product"
require_relative "category"
# Admin related activities handled here

class Admin

  def delete_product(product_id)
    i = Product.find_by_id(product_id)
    if i.nil?
      puts "Invalid Product Id"
    else
      Product.destroy(product_id)
      puts "Deleted"
    end
  end

  def add_product
    arr = UserInteraction.get_product_details
    prod = Product.new(arr)
    if prod.save
      puts "Product Saved"
    end
  end

  def add_category
    arr = UserInteraction.get_category_details
    p c = Category.new(arr)
    if c.save
      puts "Category created."
    end
  end

  def product_list
    Product.display_all
  end

  def category_list
    Category.display_all
  end

  def print_all_orders
    Order.all.each do |order|
      p '@'*65
      OrderManager.new(order).print_order
      p '@'*65
    end
  end

  def edit_product
    puts "enter product id"
    product_id = gets.chomp.to_i.to_s
    i = Product.get_index_from_id(product_id)
    if i.nil?
      puts "Invalid Product Id"
    else
      CsvOperations.delete_line_by_index($ProductFile,i)
      arr=UserInteraction.get_Product_Details
      Operations.save_product(arr,product_id)
    end
  end
end
