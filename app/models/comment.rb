# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :product
  belongs_to :user

  validates :commenter, presence: true
  validates :body, presence: true, allow_nil: false
  # validates :body, allow_nil: false, on: :update
end
