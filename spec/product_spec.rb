require 'rails_helper'

RSpec.describe Product, type: :model do
  
  describe 'Validations' do

    before(:each) do
      @category = Category.create(name: "test")
    end

    it 'saves successfully when the four fields are set' do
      @product = Product.new(name: 'blue jar', price: 100, quantity: 50, category: @category)
      expect(@product).to be_valid
    end
    
    it 'should not create a product without the name' do
      @product = Product.new(name: nil, price: 100, quantity: 50, category: @category)
      expect(@product.errors.full_messages).to include("Name can't be blank")
      expect(@product).not_to be_valid
    end

    it "should not create a product without the price" do
      @product = Product.new(name: 'blue jar', price: nil, quantity: 50, category: @category)
      expect(@product.errors.full_messages).to include("Price can't be blank")
      expect(@product).not_to be_valid
    end

    it "should not create a product without the quantity" do
      @product = Product.new(name: 'blue jar', price: 100, quantity: nil, category: @category)
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
      expect(@product).to_not be_valid
    end

    it "should not create a product without the category" do
      @product = Product.new(name: 'blue jar', price: 100, quantity: 50, category: nil)
      expect(@product.errors.full_messages).to include("Category can't be blank")
      expect(@product).to_not be_valid
    end

  end

end