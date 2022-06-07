class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  def total_price
    product.price.to_i * quantity.to_i
  end

  def to_builder
    p "in builder"

    # @user=User.find(current_user.id)
    # if user.promos.present?
      # p "promo code is present"
    # end
    @product= Product.find(self.product_id)
    Jbuilder.new do |line_item|
      line_item.name @product.name
      line_item.amount @product.price
      line_item.quantity quantity
      line_item.currency "usd"
    end
  end
end
