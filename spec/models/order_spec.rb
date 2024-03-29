# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:order){create(:order)}
  let(:user){create(:user, email: 'abd1910@gmail.com')}
  let(:product) {create(:product, user: user)}

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:order_items).dependent(:destroy) }
  end

  describe 'col-specification' do
    it { is_expected.to have_db_index(:user_id) }
  end

  context 'add_product' do
    it 'adds order_item to order' do
      expect { order.add_product(product, 2) }.to change { order.order_items.count }.from(0).to(1)
    end

  end

  context 'total_price' do
    it 'returns correct price' do
      order_item = order.add_product(product, 1)
      order_item.quantity = 4
      price = order_item.quantity * product.price
      order_item.save
      expect(order.total_price).to eq(price)
    end
  end
end
