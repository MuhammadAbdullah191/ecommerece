# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  let!(:comment){build(:comment)}
  let!(:comment_user){build(:comment, user: nil)}
  let!(:comment_pro){build(:comment, product: nil)}
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:product) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:commenter) }
    it { is_expected.to validate_presence_of(:body) }

    it 'is valid with valid attributes' do
      expect(comment).to be_valid
    end

    it 'is not valid without commenter' do
      comment.commenter=nil
      expect(comment).not_to be_valid
      expect(comment.errors.messages[:commenter]).to eq ["can't be blank"]
    end

    it 'is not valid without body' do
      comment.body=nil
      expect(comment).not_to be_valid
      expect(comment.errors.messages[:body]).to eq ["can't be blank"]
    end

    it 'is not valid without user' do
      expect(comment_user).not_to be_valid
      expect(comment_user.errors.messages[:user]).to eq ["must exist"]
    end

    it 'is not valid without product' do
      expect(comment_pro).not_to be_valid
      expect(comment_pro.errors.messages[:product]).to eq ["must exist"]
    end
  end

  describe 'col-specification' do
    it { is_expected.to have_db_column(:commenter).of_type(:string) }
    it { is_expected.to have_db_column(:body).of_type(:text) }
    it { is_expected.to have_db_index(:product_id) }
    it { is_expected.to have_db_index(:user_id) }
  end
end
