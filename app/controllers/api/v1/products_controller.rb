class Api::V1::ProductsController< ApplicationController

  def index
    # print("check q");
    # print(params);
    @q = Product.ransack({"name_cont"=>params["q"]})
    @products = @q.result(distinct: true)
    @data=[];
    @products.each do |product|
      if product.images.attached?
        @data.push({product: product,url: url_for(product.images.first)})
      else
        @data.push({product: product,url: nil})
      end
    end
    print(@data)
  end

  def show
    @product = Product.find(params[:id])
  end

  def shiftToRails
    print(params);
    print("param1s");
    redirect_to product_path(params[:id]);
  end

end
