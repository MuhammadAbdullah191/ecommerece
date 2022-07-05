# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Promo, type: :model do
  let(:promo){ build(:promo) }
  let(:invalid_user_promo){ build(:promo,user: nil) }
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:code) }
    it { is_expected.to validate_presence_of(:discount) }
    it { is_expected.to validate_presence_of(:valid_till) }

    it 'is valid with valid attributes' do
      expect(promo).to be_valid
    end

    it 'is not valid without user' do
      expect(invalid_user_promo).not_to be_valid
      expect(invalid_user_promo.errors.messages[:user]).to eq ["must exist"]
    end

    it 'is not valid without valid code' do
      promo.code= "DEV"
      expect(promo).not_to be_valid
      expect(promo.errors.messages[:code]).to eq ["is too short (minimum is 4 characters)"]
    end

    it 'is not valid without valid discount' do
      promo.discount= 1
      expect(promo).not_to be_valid
      expect(promo.errors.messages[:discount]).to eq ["must be less than or equal to 0.9"]
    end

    it 'is not valid without valid valid_till data' do
      promo.valid_till= 1
      expect(promo).not_to be_valid
      expect(promo.errors.messages[:valid_till]).to eq ["can't be blank"]
    end
  end

  describe 'col-specification' do
    it { is_expected.to have_db_column(:code).of_type(:string) }
    it { is_expected.to have_db_column(:discount).of_type(:float) }
    it { is_expected.to have_db_column(:valid_till).of_type(:datetime) }
    it { is_expected.to have_db_index(:code) }
    it { is_expected.to have_db_index(:user_id) }
  end
end
