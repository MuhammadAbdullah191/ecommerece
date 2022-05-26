class Product < ApplicationRecord
  has_many :comments, :dependent => :destroy
  belongs_to :user
  has_many :reviewers, through: :comments, source: :user
end
