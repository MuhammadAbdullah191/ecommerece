# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:product) { build(:product) }
  let(:createdProduct) { create(:product) }

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
      expect(product).to be_valid
    end

    it 'is not valid without name' do
      product.name=nil
      expect(product).not_to be_valid
      expect(product.errors.messages[:name]).to eq ["can't be blank"]
    end

    it 'is not valid without product type' do
      product.product_type= nil
      expect(product).not_to be_valid
      expect(product.errors.messages[:product_type]).to eq ["can't be blank"]
    end

    it 'is not valid without quantity' do
      product.quantity= nil
      expect(product).not_to be_valid
      expect(product.errors.messages[:quantity]).to eq ["can't be blank", "is not a number"]
    end

    it 'is not valid if quantity is < 0' do
      product.quantity= -5
      expect(product).not_to be_valid
      expect(product.errors.messages[:quantity]).to eq ["must be greater than or equal to 0"]
    end

    it 'is not valid without price' do
      product.price= nil
      expect(product).not_to be_valid
      expect(product.errors.messages[:price]).to eq ["is not a number"]
    end

    it 'is not valid if price < 500' do
      product.price= 445
      expect(product).not_to be_valid
      expect(product.errors.messages[:price]).to eq ["must be greater than or equal to 500"]
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
      createdProduct.decrement(createdProduct.id, 2)
      createdProduct.reload
      expect(createdProduct.quantity).to eq(3)
    end
  end

end
