# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LineItem, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:cart) }
    it { is_expected.to belong_to(:product) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:quantity) }

    it 'is valid with valid credintials' do
      line_item = FactoryBot.build(:line_item)
      expect(line_item).to be_valid
    end

    it 'is not valid without quantity' do
      line_item = FactoryBot.build(:line_item, quantity: nil)
      expect(line_item).not_to be_valid
    end
  end

  describe 'col-specification' do
    it { is_expected.to have_db_column(:quantity).of_type(:integer) }
    it { is_expected.to have_db_index(:product_id) }
    it { is_expected.to have_db_index(:cart_id) }
  end

  context 'total_price' do
    it 'returns the correct price' do
      line_item = FactoryBot.build(:line_item)
      price = line_item.product.price
      quantity = line_item.quantity
      total = price * quantity
      expect(line_item.total_price).to eq(total)
    end
  end

  context 'to_builder' do
    before do
      @line_item = FactoryBot.create(:line_item)
    end
    it 'returns correct json data' do
      expect(@line_item.to_builder.attributes!).to eq({"amount"=>600, "currency"=>"usd", "name"=>"testProduct", "quantity"=>5})
    end
  end
end
