# frozen_string_literal: true

class LineItemsController < ApplicationController
  include CurrentCart
  before_action :set_line_item, only: %i[show edit update destroy]
  before_action :set_cart, only: [:create]

  def index
    @line_items = LineItem.all
  end

  def show; end

  def new
    @line_item = LineItem.new
  end

  def edit; end

  def create
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product, params[:actions])

    if @line_item.save
      redirect_to @line_item.cart, notice: 'Line item was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @line_item.update(line_item_params)
      redirect_to line_item_url(@line_item), notice: 'Line item was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @cart = Cart.find(session[:cart_id])
    @line_item.destroy

    respond_to do |format|
      format.html { redirect_to cart_path(@cart), notice: 'Line item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_line_item
    @line_item = LineItem.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def line_item_params
    params.require(:line_item).permit(:product_id, :cart_id)
  end
end
