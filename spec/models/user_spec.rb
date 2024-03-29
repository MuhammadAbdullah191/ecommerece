# frozen_string_literal: true

require 'rails_helper'
RSpec.describe User, type: :model do
  let(:user){ build(:user)}
  describe 'associations' do
    it { is_expected.to have_many(:products).dependent(:destroy) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
    it { is_expected.to have_many(:reviewed_comments).through(:comments) }
    it { is_expected.to have_many(:orders).dependent(:destroy) }
    it { is_expected.to have_one(:promo).dependent(:destroy) }
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(user).to be_valid
    end

    it 'is not valid without name' do
      user.name=nil
      expect(user).not_to be_valid
      expect(user.errors.messages[:name]).to eq ["can't be blank"]
    end

    it 'is not valid without email' do
      user.email=nil
      expect(user).not_to be_valid
      expect(user.errors.messages[:email]).to eq ["can't be blank"]
    end

    it 'is not valid without proper email format' do
      user.email="abd"
      expect(user).not_to be_valid
      expect(user.errors.messages[:email]).to eq ["is invalid"]
    end

    it 'is not valid without password' do
      user.password=nil
      expect(user).not_to be_valid
      expect(user.errors.messages[:password]).to eq ["can't be blank"]
    end

    it 'is not valid without city' do
      user.city=nil
      expect(user).not_to be_valid
      expect(user.errors.messages[:city]).to eq ["can't be blank"]
    end

    it 'is not valid without street' do
      user.street=nil
      expect(user).not_to be_valid
      expect(user.errors.messages[:street]).to eq ["can't be blank"]
    end

    it 'is not valid without zip' do
      user.zip =nil
      expect(user).not_to be_valid
      expect(user.errors.messages[:zip]).to eq ["can't be blank"]
    end

    it 'is not valid without phone' do
      user.phone=nil
      expect(user).not_to be_valid
      expect(user.errors.messages[:phone]).to eq ["number is invalid. Please enter again"]
    end

    it 'is not valid without proper phone' do
      user.phone='0987557'
      expect(user).not_to be_valid
      expect(user.errors.messages[:phone]).to eq ["number is invalid. Please enter again"]
    end

    it 'retruns valid email' do
      user = FactoryBot.build(:user)
      expect(user.to_s).to eq(user.email)
    end
  end

  describe 'col-specification' do
    it { is_expected.to have_db_column(:name).of_type(:string) }
    it { is_expected.to have_db_column(:email).of_type(:string) }
    it { is_expected.to have_db_column(:city).of_type(:string) }
    it { is_expected.to have_db_column(:street).of_type(:string) }
    it { is_expected.to have_db_column(:zip).of_type(:string) }
    it { is_expected.to have_db_index(:email) }
  end

  describe 'callback' do
    it 'gets stripe customer id using after create callback' do
      user=FactoryBot.build(:user)
      expect(user).to receive(:update_stripe_customer)
      user.save
    end

    it 'correctly updates stripe customer id' do
      user = FactoryBot.create(:user)
      expect(user.stripe_customer_id).not_to be_nil
    end
  end
end
