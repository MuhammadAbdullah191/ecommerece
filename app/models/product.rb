# frozen_string_literal: true

class Product < ApplicationRecord
  has_many :comments, dependent: :destroy
  belongs_to :user
  has_many :reviewers, through: :comments, source: :user
  has_many_attached :images
  has_many :line_items, dependent: :destroy
  has_many :order_items, dependent: :destroy
  before_destroy :not_referenced_by_any_line_item

  validates :name, presence: true
  validates :product_type, presence: true
  validates :quantity, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 500 }
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
  validate :validate_image
  def validate_image
    errors.add :images, 'SHOULD BE ATTACHED ATLEAST 1' unless images.attached?
  end

  def decrement(id, qua)
    @product = Product.find(id)
    @product.quantity = @product.quantity - qua
    @product.save
  end

  def not_referenced_by_any_line_item
    return if line_items.empty?

    errors.add(:base, 'Line items present')
    throw :abort
  end

  after_create do
    serial_number = Digest::SHA1.hexdigest([Time.zone.now, rand].join)
    update(serial_number: serial_number)
  end
end
