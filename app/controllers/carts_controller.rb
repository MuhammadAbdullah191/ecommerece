# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :set_cart, only: %i[show edit update destroy]

  def index
    @carts = Cart.all
  end

  def show; end

  def edit; end

  def create
    @cart = Cart.new(cart_params)

    redirect_to cart_url(@cart), notice: 'Cart was successfully created.' if @cart.save
  end

  def update
    redirect_to cart_url(@cart), notice: 'Cart was successfully updated.' if @cart.update(cart_params)
  end

  def destroy
    @cart.destroy if @cart.id == session[:cart_id]
    session[:cart_id] = nil

    redirect_to root_path, notice: 'Cart was successfully destroyed.'
    # head :no_content
  end

  def success; end

  private

  def set_cart
    @cart = Cart.find(params[:id])
    @count = 0
    if user_signed_in?
      @cart.line_items.each do |line_item|
        next unless line_item.product.user_id == current_user.id

        @count += 1
        line_item.destroy
      end
    else
      Rails.logger.debug 'here'
    end
    @cart
  end

  # Only allow a list of trusted parameters through.
  def cart_params
    params.fetch(:cart, {})
  end
end
