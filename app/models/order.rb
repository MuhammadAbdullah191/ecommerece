# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy

  def add_product(product, quantity)
    current_item = order_items.find_by(product_id: product.id)

    if current_item
    else
      current_item = order_items.new(product_id: product.id, price: product.price, quantity: quantity)
      current_item.save
    end
    current_item
  end

  def total_price
    order_items.to_a.sum(&:total_price)
  end
end
