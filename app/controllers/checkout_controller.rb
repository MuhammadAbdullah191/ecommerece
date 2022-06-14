# frozen_string_literal: true

class CheckoutController < ApplicationController
  before_action :authenticate_user!
  def create
    @data = @cart.line_items.collect { |item| item.to_builder.attributes! }
    if current_user.promo.present?
      @data.each do |d|
        d['amount'] = d['amount'] * current_user.promo.discount
        d['amount'] = d['amount'].to_i
      end
    end

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
    createOrder
  end

  def createOrder
    ActiveRecord::Base.transaction do
      Rails.logger.debug 'in checkout'
      session = Stripe::Checkout::Session.retrieve(params[:session_id])
      @count = 0
      @user = User.find_by(stripe_customer_id: session.customer)
      @order = Order.create(user_id: @user.id)
      @cart.line_items.each do |line_item|
        @product = Product.find(line_item.product_id)
        @order.add_product(@product, line_item.quantity)
      end
      decrementQuantity
      @cart.destroy
    rescue ActiveRecord::Rollback
      redirect_to cart_path(@cart), alert: 'Error while checking out. Please Try Again'
    rescue Exception

      redirect_to cart_path(@cart), alert: 'Exception while checking out. Please Try Again'
    end

    # end
  end

  def decrementQuantity
    @cart.line_items.each do |line_item|
      @product = Product.find(line_item.product_id)
      @product.decrement(line_item.product_id, line_item.quantity)
    end
  end
end
