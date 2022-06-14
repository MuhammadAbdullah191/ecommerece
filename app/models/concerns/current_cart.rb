# frozen_string_literal: true

module CurrentCart
  private

  def set_cart
    @cart = Cart.find(session[:cart_id])
    @count = 0
    if user_signed_in?
      @cart.line_items.each do |line_item|
        next unless line_item.product.user_id == current_user.id

        Rails.logger.debug('users is looged in')
        Rails.logger.debug(@count)
        @count += 1
        line_item.destroy
      end

    end
  rescue ActiveRecord::RecordNotFound
    @cart = Cart.create
    session[:cart_id] = @cart.id
  end
end
