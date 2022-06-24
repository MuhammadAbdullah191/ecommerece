# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Promo, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:code) }
    it { is_expected.to validate_presence_of(:discount) }
    it { is_expected.to validate_presence_of(:valid_till) }

    it 'is valid with valid attributes' do
      promo = FactoryBot.build(:promo)
      expect(promo).to be_valid
    end

    it 'is not valid without user' do
      promo = FactoryBot.build(:promo, user: nil)
      expect(promo).not_to be_valid
    end

    it 'is not valid without valid code' do
      promo = FactoryBot.build(:promo, code: 'DEV')
      expect(promo).not_to be_valid
    end

    it 'is not valid without valid discount' do
      promo = FactoryBot.build(:promo, discount: 1)
      expect(promo).not_to be_valid
    end

    it 'is not valid without valid valid_till data' do
      promo = FactoryBot.build(:promo, valid_till: 1)
      expect(promo).not_to be_valid
    end
  end
end
