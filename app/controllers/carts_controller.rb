# frozen_string_literal: true

class CartsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart
  before_action :set_cart, only: %i[show edit update destroy]

  def index
    @carts = Cart.all
  end

  def show; end

  def new
    @cart = Cart.new
  end

  def edit; end

  def create
    @cart = Cart.new(cart_params)

    if @cart.save
      redirect_to cart_url(@cart), notice: 'Cart was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @cart.update(cart_params)
      redirect_to cart_url(@cart), notice: 'Cart was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
      render json: @cart.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @cart.destroy if @cart.id == session[:cart_id]
    session[:cart_id] = nil

    redirect_to root_path, notice: 'Cart was successfully destroyed.'
    head :no_content
  end

  def success
    Rails.logger.debug 'in the success controller'
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
  end

  # Only allow a list of trusted parameters through.
  def cart_params
    params.fetch(:cart, {})
  end

  def invalid_cart
    logger.error "Attempt to access invalid cart #{params[:id]}"
    redirect_to root_path, notice: 'That cart deleted succssfully'
  end
end
