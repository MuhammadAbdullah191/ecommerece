# frozen_string_literal: true

class OrderItemsController < ApplicationController
  before_action :set_order_item, only: %i[show edit update destroy]

  def index
    @order_items = OrderItem.all
  end

  def show; end

  def new
    @order_item = OrderItem.new
  end

  def edit; end

  # POST /order_items or /order_items.json
  def create
    @order_item = OrderItem.new(order_item_params)

    if @order_item.save
      redirect_to order_item_url(@order_item), notice: 'Order item was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /order_items/1 or /order_items/1.json
  def update
    if @order_item.update(order_item_params)
      redirect_to order_item_url(@order_item), notice: 'Order item was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /order_items/1 or /order_items/1.json
  def destroy
    @order_item.destroy
    redirect_to order_items_url, notice: 'Order item was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_order_item
    @order_item = OrderItem.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def order_item_params
    params.require(:order_item).permit(:product_id, :order_id)
  end
end
