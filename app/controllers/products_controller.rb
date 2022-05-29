class ProductsController < ApplicationController
  def index
    @products=Product.all();
  end

  def show
    @product=Product.find(params[:id])
  end

  def create
    @user=User.find(params[:user_id])
    @product=@user.products.create(product_params)
    redirect_to user_path(@user)
  end

  def edit
    puts("params");
    puts(params);
    puts("params");
    @product=Product.find(params[:id])
  end

  def update
    @product=Product.find(params[:id])

    if @product.update(product_params)
      redirect_to @product
    else
      render :edit
    end
  end

  def destroy
    @product=Product.find(params[:id])
    @product.destroy

    redirect_to root_path, status: :see_other
  end

  private
  def product_params
    params.require(:product).permit(:name, :product_type, images: [])
  end
end
