# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:product) }
    it { is_expected.to belong_to(:order) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:quantity) }
    it { is_expected.to validate_presence_of(:price) }

    it 'is valid with valid credintials' do
      order_item = FactoryBot.build(:order_item)
      expect(order_item).to be_valid
    end

    it 'is not valid without quantity' do
      order_item = FactoryBot.build(:order_item, quantity: nil)
      expect(order_item).not_to be_valid
    end
  end

  describe 'total_price' do
    it 'returns the correct price' do
      order_item = FactoryBot.build(:order_item)
      price = order_item.product.price
      quantity = order_item.quantity
      total = price * quantity
      expect(order_item.total_price).to eq(total)
    end
  end
end
