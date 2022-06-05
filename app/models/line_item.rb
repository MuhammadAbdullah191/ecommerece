class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  def total_price
    product.price.to_i * quantity.to_i
  end

  def to_builder
    Jbuilder.new do |line_item|
      line_item.price 999
      line_item.quantity quantity
    end
  end
end
