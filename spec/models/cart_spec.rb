# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:line_items).dependent(:destroy) }
  end

  describe 'add_product' do
    it 'adds line_item to cart' do
      cart = FactoryBot.create(:cart)
      product = FactoryBot.create(:product)
      line_item = cart.add_product(product, '+')
      expect { line_item.save }.to change { cart.line_items.count }.from(0).to(1)
    end

    it 'increments quantity of line_item to cart' do
      cart = FactoryBot.create(:cart)
      product = FactoryBot.create(:product)
      line_item = cart.add_product(product, '+')
      line_item.save
      line_item = cart.add_product(product, '+')
      line_item.save
      expect(cart.line_items.count).to eq(1)
    end

    it 'decrements the quantity of line_item in cart' do
      cart = FactoryBot.create(:cart)
      product = FactoryBot.create(:product)
      line_item = cart.add_product(product, '+')
      line_item.quantity = 2
      line_item.save
      expect do
        line_item = cart.add_product(product, '-')
        line_item.save
      end.to change { cart.line_items.first.quantity }.from(2).to(1)
    end

    it 'does not decrement the quantity of line_item in cart if quantity is 1' do
      cart = FactoryBot.create(:cart)
      product = FactoryBot.create(:product)
      line_item = cart.add_product(product, '+')
      line_item.save
      expect do
        line_item = cart.add_product(product, '-')
        line_item.save
      end.not_to change { cart.line_items.first.quantity }.from(1)
    end
  end

  describe 'total_price' do
    it 'returns correct price' do
      cart = FactoryBot.create(:cart)
      product = FactoryBot.create(:product)
      line_item = cart.add_product(product, '+')
      line_item.quantity = 2
      price = line_item.quantity * product.price
      line_item.save
      expect(cart.total_price).to eq(price)
    end
  end
end
