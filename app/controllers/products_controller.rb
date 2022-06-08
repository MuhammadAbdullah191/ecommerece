class ProductsController < ApplicationController
  def index
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true)
    if user_signed_in?
      p "current_user"
      p current_user.promo
    end
    # @products=Product.all();
  end

  def show
    @product=Product.find(params[:id])
  end
  def new
    @product = Product.new
  end

  def create
    p "I am here"
    p current_user.id
    p "current_user.id"
    @user=User.find(current_user.id)
    @product=@user.products.create(product_params)

    if @product.save
      redirect_to user_path(@user)
    else
      p "here"
      p @product.errors.messages
      render :new
    end
    # @product=@user.products.create(product_params)

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
    session[:return_to] ||= request.referer
    @product=Product.find(params[:id])
    @product.destroy
    redirect_to session.delete(:return_to)
    # redirect_to root_path, status: :see_other
  end

  private
  def product_params
    params.require(:product).permit(:name, :product_type,:quantity, :price, images: [] )
  end
end
