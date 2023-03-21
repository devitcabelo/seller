require 'rails_helper'

RSpec.describe Purchase, type: :model do
  context 'validate purchase by product quantity' do
    let(:product) { Product.create(name: 'Tomate', price: 10.0, quantity: 10) }
    let(:user) { User.create(name: 'Gabriel', email: "teste@teste.com", password: "teste1234") }
    
    it 'ensures purchase can be created by product quantity' do
        purchase = Purchase.create(
          product: product,
          user: user,
          quantity: 2
        ) 
        expect(product.quantity).to eq(8)
    end

    it 'ensures purchase can not be created by product quantity' do
      purchase = Purchase.new(
        product: product,
        user: user,
        quantity: 20
      )
      purchase.validate
      expect(purchase.errors[:quantity]).to include('insufficient stock')
    end

    it 'ensures purchase quantity adjust after update' do
      purchase = Purchase.create(
        product: product,
        user: user,
        quantity: 2
      )
      purchase.update(
        quantity: 5
      ) 
      expect(product.quantity).to eq(5)
    end
  end
end