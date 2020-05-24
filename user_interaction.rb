# cli's Interactions are handled here
# it prints msgs and gets inputs
class UserInteraction
  def self.get_product_details
    data = {}
    $ProductProperties.drop(1).each do | pr|
      print "Enter Product #{pr} :"
      data[pr] = gets.chomp
    end
    data
  end

  def self.get_category_details
    data = {}
    $CategoryProperties.drop(1).each do | pr|
      print "Enter Category #{pr} :"
      data[pr] = gets.chomp
    end
    data
  end

  def self.get_user_details
    data = {}
    ['name', 'email'].each do | pr|
      print "Enter your #{pr} :"
      data[pr] = gets.chomp
    end
    data
  end

  def self.get_product_id
    puts "Enter product id"
    gets.chomp
  end

  def self.get_category_id
    puts "Enter category id"
    gets.chomp
  end

  def self.add_to_cart_details
    data = {}
    ['product_id', 'quantity'].each do | pr|
      print "Enter your #{pr} :"
      data[pr] = gets.chomp
    end
    data
  end

  def self.show_options
    puts "Enter Your Choice"
    puts "Login As :"
    puts "1:Admin 2:User"
  end

  def self.show_admins_menu
    puts "\nEnter Your Choice"
    puts "1: Add Product \n2: Remove Product \n3: List Products \n4: Add Category \n5: List Categories\n6: List Orders \n7:Exit"
  end

  def self.show_users_menu
    puts "\nEnter Your Choice"
    puts "1: List Categories \n2: List Product from Category \n3: add Product to cart \n4: Remove Product from cart \n5: Complete Order \n6: List Order \n7:Exit"
  end
end
