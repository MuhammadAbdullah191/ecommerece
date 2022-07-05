# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  let(:order_item){ build(:order_item)}
  describe 'associations' do
    it { is_expected.to belong_to(:product) }
    it { is_expected.to belong_to(:order) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:quantity) }
    it { is_expected.to validate_presence_of(:price) }

    it 'is valid with valid credintials' do
      expect(order_item).to be_valid
    end

    it 'is not valid without quantity' do
      order_item.quantity= nil
      expect(order_item).not_to be_valid
      expect(order_item.errors.messages[:quantity]).to eq ["can't be blank"]
    end
  end

  describe 'col-specification' do
    it { is_expected.to have_db_column(:price).of_type(:integer) }
    it { is_expected.to have_db_column(:quantity).of_type(:integer) }
    it { is_expected.to have_db_index(:product_id) }
    it { is_expected.to have_db_index(:order_id) }
  end

  context 'total_price' do
    it 'returns the correct price' do
      price = order_item.product.price
      quantity = order_item.quantity
      total = price * quantity
      expect(order_item.total_price).to eq(total)
    end
  end
end
