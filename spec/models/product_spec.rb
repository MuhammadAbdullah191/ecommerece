# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:product) { FactoryBot.build(:product) }

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
    it { is_expected.to have_many(:reviewers).through(:comments) }
    it { is_expected.to have_many(:line_items).dependent(:destroy) }
    it { is_expected.to have_many(:order_items).dependent(:destroy) }
    it { is_expected.to have_many_attached(:images) }
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      product = FactoryBot.build(:product)
      expect(product).to be_valid
    end

    it 'is not valid without name' do
      product = FactoryBot.build(:product, name: nil)
      expect(product).not_to be_valid
    end

    it 'is not valid without product type' do
      product = FactoryBot.build(:product, product_type: nil)
      expect(product).not_to be_valid
    end

    it 'is not valid without quantity' do
      product = FactoryBot.build(:product, quantity: nil)
      expect(product).not_to be_valid
    end

    it 'is not valid if quantity is < 0' do
      product = FactoryBot.build(:product, quantity: -5)
      expect(product).not_to be_valid
    end

    it 'is not valid without price' do
      product = FactoryBot.build(:product, price: nil)
      expect(product).not_to be_valid
    end

    it 'is not valid if price < 500' do
      product = FactoryBot.build(:product, price: 445)
      expect(product).not_to be_valid
    end

    it 'is not valid if no image is attahed' do
      product = FactoryBot.build(:product, images: nil)
      expect(product).not_to be_valid
    end
  end

  describe 'col-specification' do
    it { is_expected.to have_db_column(:name).of_type(:string) }
    it { is_expected.to have_db_column(:product_type).of_type(:string) }
    it { is_expected.to have_db_column(:price).of_type(:integer) }
    it { is_expected.to have_db_column(:quantity).of_type(:integer) }
    it { is_expected.to have_db_index(:user_id) }
  end

  describe 'callback' do
    it 'update serial number runs after creation' do
      expect(product).to receive(:update_serial_number)
      product.save
    end
  end

  context 'decrement' do
    it 'decrements the product quantity' do
      product = FactoryBot.create(:product)
      product.decrement(product.id, 2)
      product.reload
      expect(product.quantity).to eq(3)
    end
  end

end
