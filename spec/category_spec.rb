require_relative '../category'

describe Category do
  it 'should be valid if these attributes present' do
    @object = Category.new('name' => 'XYZ')
    expect(@object.save).to be true
  end

  it 'should not create if name is not present' do
    @object = Category.new()
    expect(@object.save).to be_nil
  end
end