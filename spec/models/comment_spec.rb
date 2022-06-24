# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:product) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:commenter) }
    it { is_expected.to validate_presence_of(:body) }

    it 'is valid with valid attributes' do
      comment = FactoryBot.build(:comment)
      expect(comment).to be_valid
    end

    it 'is not valid without commenter' do
      comment = FactoryBot.build(:comment, commenter: nil)
      expect(comment).not_to be_valid
    end

    it 'is not valid without body' do
      comment = FactoryBot.build(:comment, body: nil)
      expect(comment).not_to be_valid
    end

    it 'is not valid without user' do
      comment = FactoryBot.build(:comment, user_id: nil)
      expect(comment).not_to be_valid
    end

    it 'is not valid without product' do
      comment = FactoryBot.build(:comment, product_id: nil)
      expect(comment).not_to be_valid
    end
  end
end
