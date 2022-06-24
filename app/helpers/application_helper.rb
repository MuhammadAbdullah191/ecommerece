# frozen_string_literal: true

module ApplicationHelper
  def cart_count_over_one
    return total_cart_items if total_cart_items.positive?
  end

  def total_cart_items
    if @cart
      total = @cart.line_items.map(&:quantity).sum
      return total if total.positive?
    end


  end
  def products
    q = Product.ransack(params[:q])
    q.result(distinct: true)
    return q
  end
end
