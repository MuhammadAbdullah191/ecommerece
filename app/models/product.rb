class PriceValidator < ActiveModel::Validator
  def validate(record)
    unless record.price >500;
      record.errors.add :price, "should be greater then 500"
    end
  end
end

class QuantityValidator < ActiveModel::Validator
  def validate(record)
    unless record.quantity >0;
      record.errors.add :quantity, "should be greater then 0"
    end
  end
end

class Product < ApplicationRecord
  include ActiveModel::Validations
  validates :name, presence: true, on: :create
  validates :product_type, presence: true, on: :create
  validates :quantity, presence: true, on: :create
  validates :price, presence: true, on: :create
  validates_with PriceValidator
  validates_with QuantityValidator
  # Validations




  before_destroy :not_referenced_by_any_line_item
  has_many :comments, :dependent => :destroy
  belongs_to :user
  has_many :reviewers, through: :comments, source: :user
  has_many_attached :images
  has_many :line_items

  def not_referenced_by_any_line_item
    unless line_items.empty?
      errors.add(:base, "Line items present")
      throw :abort
    end
  end
end
