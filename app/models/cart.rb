# frozen_string_literal: true

class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy

  def add_product(product, action)
    current_item = line_items.find_by(product_id: product.id)
    print("current-item");
    print(current_item);
    if action == '+'
      if current_item
        current_item.increment(:quantity) if current_item.product.quantity > current_item.quantity
      else
        current_item = line_items.build(product_id: product.id)
      end
      current_item
    elsif current_item.quantity == 1
      current_item.destroy
    elsif action=="0"
      current_item.destroy
    else
      current_item.decrement(:quantity)
    end
  end

  def total_price
    line_items.to_a.sum(&:total_price)
  end
end
