class ProductsController < ApplicationController
  def index
  end

  def show
  end

  def create
    @user=User.find(params[:user_id])
    @product=@user.products.create(product_params)
    redirect_to user_path(@user)
  end

  private
  def product_params
    params.require(:product).permit(:name, :product_type)
  end
end
