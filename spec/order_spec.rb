require_relative '../order'
require_relative '../line_item'

describe Order  do
  it 'will initialise order with cart status' do
    order = Order.new(name: 'xyz', email: 'abc@gmail.com')
    order.save
    expect(order.attrs['status']).to eq 'cart'
  end

  it 'will change status to completed when complete' do
    order = Order.new(name: 'xyz', email: 'abc@gmail.com')
    order.complete
    expect(order.attrs['status']).to eq 'completed'
  end

  it 'will add 500 discount for order greater than 10000' do
    order = Order.new(name: 'xyz', email: 'abc@gmail.com')
    order = Order.current_order
    LineItem.new('order_id' => order.attrs['id'], 'product_id' => 1, 'quantity' => 1, 'amount' => 10001).save
    order = Order.current_order
    expect(order.attrs['sub_total'].to_i - order.attrs['amount'].to_i).to eq 500
  end

end