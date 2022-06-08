class PriceValidator < ActiveModel::Validator
  def validate(record)
    if record.price
      unless record.price >500;
        record.errors.add :price, "should be greater then 500"
      end
    end

  end
end

class QuantityValidator < ActiveModel::Validator
  def validate(record)
    if record.quantity
      unless record.quantity >0;
        record.errors.add :quantity, "should be greater then 0"
      end
    end

  end
end

class ImageValidator < ActiveModel::Validator
  def validate(record)
    if !record.images.attached?
        record.errors.add :images, "SHOULD BE ATTACHED ATLEAST 1"
    end

  end
end

class Product < ApplicationRecord
  include ActiveModel::Validations
  validates :name, presence: true
  validates :product_type, presence: true
  validates :quantity, presence: true
  validates :price, presence: true
  # validates :images, presence: true, on: :create, :message => "can't be empty"
  validates_with PriceValidator
  validates_with QuantityValidator
  validates_with ImageValidator
  # Validations




  before_destroy :not_referenced_by_any_line_item
  has_many :comments, :dependent => :destroy
  belongs_to :user
  has_many :reviewers, through: :comments, source: :user
  has_many_attached :images
  has_many :line_items
  has_many :order_items

  def decrement(id,qua)
    p "in product decrement"
    @product=Product.find(id)
    @product.quantity=@product.quantity-qua
    @product.save
  end

  def not_referenced_by_any_line_item
    unless line_items.empty?
      errors.add(:base, "Line items present")
      throw :abort
    end
  end
end
