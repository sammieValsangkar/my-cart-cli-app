# require_relative 'd_b_adapter'
require_relative 'admin'
require_relative 'user'
require_relative 'user_interaction'
require_relative 'line_item'
require_relative 'order'

$ProductProperties = %w[id name price description category_id]
$CategoryProperties = %w[id name description]

# Main store class to init the App
class Store
  def admins_dashboard
    admin = Admin.new
    loop do
      UserInteraction.show_admins_menu
      admin_choice = gets.chomp.to_i
      case admin_choice
      when 1
        admin.add_product
      when 2
        puts 'product_id :'
        admin.delete_product(gets.to_i)
      when 3
        admin.product_list
      when 4
        admin.add_category
      when 5
        admin.category_list
      when 6
        admin.print_all_orders
      when 7
        exit
      end
    end
  end

  def users_dashboard
    user = User.new
    loop do
      UserInteraction.show_users_menu
      users_choice = gets.chomp.to_i
      case users_choice
      when 1
        user.category_list
      when 2
        user.list_product_from_category
      when 3
        user.add_to_cart
      when 4
        user.remove_from_cart
      when 5
        user.complete_order
      when 6
        user.print_all_orders
      when 7
        exit
      end
    end
  end

  def launch
    UserInteraction.show_options
    loop do
      choice = gets.chomp.to_i
      case choice
      when 1
        admins_dashboard
      when 2
        users_dashboard
      end
    end
  end
end

s = Store.new
s.launch
