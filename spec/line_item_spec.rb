require_relative '../line_item'
require_relative '../order'

describe LineItem do
  it 'will update order when created' do
    order = Order.new(name: 'xyz', email: 'abc@gmail.com').save
    order = Order.current_order
    @object = LineItem.new('product_id' => 1, 'amount' => 123 ,'quantity' => 1, 'order_id' => order.attrs['id'])
    expect(@object).to receive(:update_order)
    @object.save
    # Order.current_order.complete
  end

  it 'should be valid if these attributes present' do
    order = Order.new(name: 'xyz', email: 'abc@gmail.com')
    order = Order.current_order
    @object = LineItem.new('product_id' => 1, 'amount' => 123 ,'quantity' => 1, 'order_id' => order.attrs['id'])
    expect(@object.save).to be true
    Order.current_order.complete
  end

  it 'should not create if product_id is not present' do
    @object = LineItem.new('amount' => 123 ,'quantity' => 1, 'order_id' => 1)
    expect(@object.save).to be_nil
  end

  it 'should not create if order_id is not present' do
    @object = LineItem.new('product_id' => 1, 'amount' => 123 ,'quantity' => 1,)
    expect(@object.save).to be_nil
  end

  it 'should not create if amount is not present' do
    @object = LineItem.new('product_id' => 1,'quantity' => 1, 'order_id' => 1)
    expect(@object.save).to be_nil
  end

  it 'should not create if quantity is not present' do
    @object = LineItem.new('product_id' => 1, 'amount' => 123 , 'order_id' => 1)
    expect(@object.save).to be_nil
  end

  it 'should not create if quantity is invalid' do
    @object = LineItem.new('product_id' => 1, 'amount' => 123 ,'quantity' => -1, 'order_id' => 1)
    expect(@object.save).to be_nil
  end
end