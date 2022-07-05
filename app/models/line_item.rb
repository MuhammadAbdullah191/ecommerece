# frozen_string_literal: true

class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  validates :quantity, presence: true

  def total_price
    product.price.to_i * quantity.to_i
  end

  def to_builder
    @product = Product.find(product_id)
    Jbuilder.new do |line_item|
      line_item.name @product.name
      line_item.amount @product.price
      line_item.quantity quantity
      line_item.currency 'usd'
    end
  end
end
