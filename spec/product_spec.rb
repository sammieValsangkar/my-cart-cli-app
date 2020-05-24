require_relative '../product'

describe Product do
  it 'should be valid if these attributes present' do
    @object = Product.new('name' => 'XYZ', 'description' => 'something', 'price' => 1, 'category_id' => 1)
    expect(@object.save).to be true
  end

  it 'should not create if name is not present' do
    @object = Product.new('description' => 'something', 'price' => 1, 'category_id' => 1)
    expect(@object.save).to be_nil
  end

  it 'should not create if description is not present' do
    @object = Product.new('name' => 'XYZ', 'price' => 1, 'category_id' => 1)
    expect(@object.save).to be_nil
  end

  it 'should not create if category_id is not present' do
    @object = Product.new('name' => 'XYZ', 'description' => 'something', 'price' => 1)
    expect(@object.save).to be_nil
  end

  it 'should not create if price is not present' do
    @object = Product.new('name' => 'XYZ', 'description' => 'something', 'category_id' => 1)
    expect(@object.save).to be_nil
  end

  it 'should not create if price is invalid' do
    @object = Product.new('name' => 'XYZ', 'description' => 'something', 'category_id' => 1, 'price' => -1)
    expect(@object.save).to be_nil
  end
end