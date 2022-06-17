# # frozen_string_literal: true

# class CheckoutController < ApplicationController
#   before_action :authenticate_user!
#   before_action :set_data, only: [:fetch_data]
#   # before_action :create_order, only: [:fetch_data]
#   # before_action :set_data, only: [:fetch_data,:create_order_data]
#   before_action :create_order_data, only: [:create_order]

#   def set_data
#     @data = @cart.line_items.collect { |item| item.to_builder.attributes! }
#   end

#   def fetch_data
#     return if current_user.promo.blank?

#     @data.each do |d|
#       d['amount'] = d['amount'] * current_user.promo.discount
#       d['amount'] = d['amount'].to_i
#     end
#   end

#   def create
#     @session = session
#   end

#   respond_to do |format|
#     format.js
#   end

#   def success
#     create_order
#   end

#   def create_order
#     ActiveRecord::Base.transaction do
#       Rails.logger.debug 'in checkout'
#       decrement_quantity
#       @cart.destroy
# rescue ActiveRecord::Rollback
#   redirect_to cart_path(@cart), alert: 'Error while checking out. Please Try Again'
# rescue ActiveRecord::RecordInvalid
#   redirect_to cart_path(@cart), alert: 'Invalid Record Please try again'
# rescue StandardError
#   redirect_to cart_path(@cart), alert: 'Exception while checking out. Please Try Again'
# end

#     # end
#   end

#   def decrement_quantity
#     @cart.line_items.each do |line_item|
#       @product = Product.find(line_item.product_id)
#       @product.decrement(line_item.product_id, line_item.quantity)
#     end
#   end

#   private

#   def session
#     Rails.logger.debug('')
#     @data = fetch_data
#     Rails.logger.debug(@data)
#     Stripe::Checkout::Session.create({
#                                        customer: current_user.stripe_customer_id,
#                                        payment_method_types: ['card'],
#                                        line_items: @data,
#                                        allow_promotion_codes: true,
#                                        mode: 'payment',
#                                        success_url: "#{success_url}?session_id={CHECKOUT_SESSION_ID}",
#                                        cancel_url: 'https://www.google.com/?client=safari'
#                                      })
#   end

#   def create_order_data
#     session = Stripe::Checkout::Session.retrieve(params[:session_id])
#     @count = 0
#     @user = User.find_by(stripe_customer_id: session.customer)
#     @order = Order.create(user_id: @user.id)
#     @cart.line_items.each do |line_item|
#       @product = Product.find(line_item.product_id)
#       @order.add_product(@product, line_item.quantity)
#     end
#   end
# end

# frozen_string_literal: true

class CheckoutController < ApplicationController
  before_action :authenticate_user!

  def create
    @data = set_data
    @session = Stripe::Checkout::Session.create({
                                                  customer: current_user.stripe_customer_id,
                                                  payment_method_types: ['card'],
                                                  line_items: @data,
                                                  allow_promotion_codes: true,
                                                  mode: 'payment',
                                                  success_url: "#{success_url}?session_id={CHECKOUT_SESSION_ID}",
                                                  cancel_url: 'https://www.google.com/?client=safari'
                                                })
  end

  respond_to do |format|
    format.js
  end

  def success
    create_order
  end

  def create_order
    ActiveRecord::Base.transaction do
      set_order
      decrement_quantity
      @cart.destroy
    rescue ActiveRecord::Rollback
      redirect_to cart_path(@cart), alert: 'Error while checking out. Please Try Again'
    rescue ActiveRecord::RecordInvalid
      redirect_to cart_path(@cart), alert: 'Invalid Record Please try again'
    rescue StandardError
      redirect_to cart_path(@cart), alert: 'Exception while checking out. Please Try Again'
    end

    # end
  end

  def decrement_quantity
    @cart.line_items.each do |line_item|
      @product = Product.find(line_item.product_id)
      @product.decrement(line_item.product_id, line_item.quantity)
    end
  end

  private

  def set_data
    @data = @cart.line_items.collect { |item| item.to_builder.attributes! }
    if current_user.promo.present?
      @data.each do |d|
        d['amount'] = d['amount'] * current_user.promo.discount
        d['amount'] = d['amount'].to_i
      end
    end
    @data
  end

  def set_order
    session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @user = User.find_by(stripe_customer_id: session.customer)
    @order = Order.create(user_id: @user.id)
    @cart.line_items.each do |line_item|
      @product = Product.find(line_item.product_id)
      @order.add_product(@product, line_item.quantity)
    end
  end
end
