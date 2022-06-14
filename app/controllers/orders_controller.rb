# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :set_order, only: %i[show edit update destroy]

  def index
    @orders = Order.all
  end

  def show; end

  def new
    @order = Order.new
  end

  def edit; end

  def create
    @order = Order.new(order_params)

      if @order.save
        redirect_to order_url(@order), notice: 'Order was successfully created.'
        render :new, status: :unprocessable_entity
      end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
      if @order.update(order_params)
        redirect_to order_url(@order), notice: 'Order was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order.destroy
    redirect_to orders_url, notice: 'Order was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def order_params
    params.fetch(:order, {})
  end
end
