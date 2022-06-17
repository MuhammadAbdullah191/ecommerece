# frozen_string_literal: true

class ProductsController < ApplicationController
  def index
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true)
  end

  def show
    @product = Product.find(params[:id])
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true)
  end

  def new
    @product = Product.new
  end

  def create
    @user = User.find(current_user.id)
    @product = @user.products.create(product_params)

    if @product.save
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
    authorize @product
  end

  def update
    @product = Product.find(params[:id])

    if @product.update(product_params)
      redirect_to @product
    else
      render :edit
    end
  end

  def destroy
    session[:return_to] ||= request.referer
    @product = Product.find(params[:id])
    authorize @product
    @product.destroy
    redirect_to session.delete(:return_to)
  end

  def delete_image_attachment
    @image = ActiveStorage::Blob.find_signed(params[:id])
    @image.purge_later
    redirect_to product_path(@product)
  end

  private

  def product_params
    params.require(:product).permit(:name, :product_type, :quantity, :price, images: [])
  end
end
