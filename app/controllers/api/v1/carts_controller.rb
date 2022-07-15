# frozen_string_literal: true

class Api::V1::CartsController < ApplicationController
  before_action :set_cart, only: %i[show edit update destroy]
  skip_before_action :verify_authenticity_token

  def index
    @carts = Cart.all
  end

  def show
    print("@params is")
    print(params)
    @cart = Cart.find(params[:id])
    @count = 0
    print("@cart is");

    @data = @cart.line_items.collect { |item| item.to_builders.attributes! }

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

  def edit; end

  def create
    @cart = Cart.new(cart_params)

    redirect_to cart_url(@cart), notice: 'Cart was successfully created.' if @cart.save
  end

  def update
    redirect_to cart_url(@cart), notice: 'Cart was successfully updated.' if @cart.update(cart_params)
  end

  def destroy
    print("destroy path");
    @cart = Cart.find(params[:id])
    @cart.destroy
    # @cart.destroy if @cart.id == session[:cart_id]
    # session[:cart_id] = nil

    # redirect_to root_path, notice: 'Cart was successfully destroyed.'
    # head :no_content
  end

  def success; end

  def changeItem
    @cart = Cart.find(params[:id])
    print("change item params")
    print(params)
    product = Product.find(params[:pro_id])
    print(product.quantity)
    @line_item = @cart.add_product(product, params[:sign])
    print(@line_item.quantity)
    @line_item.save
    @data = @cart.line_items.collect { |item| item.to_builders.attributes! }
  end

  def getPrice
    @cart = Cart.find(params[:id])
    @price=@cart.total_price
  end

  def checkout
    print("in checkout");
    redirect_to checkout_index_path
  end
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
