class CommentsController < ApplicationController
  def index
  end

  def show
    @comment= Comment.find(params[:id])
  end
  def create
    print "in comment create"
    @product=Product.find(params[:product_id])
    p @product
    if user_signed_in?
      puts "user is signed in"
      # puts current_user.id
      puts comment_params
      @comment=@product.comments.new(comment_params)
      @comment.user_id=current_user.id
      @comment.commenter=current_user.email
      @comment.save
      p @comment.errors.full_messages
    else
      puts "user not signed in"
    end

    # redirect_to product_path(@product)
  end

  def edit
    session[:return_to] ||= request.referer
    puts("params");
    puts(params);
    puts(params[:comment]);
    puts("params");
    @comment=Comment.find(params[:id])

  end

  def update
    @comment=Comment.find(params[:id])

    if @comment.update(comment_params)
      redirect_to session.delete(:return_to)
      # redirect_to product_path(@product)
    else
      render :edit
    end
  end

  def destroy
    session[:return_to] ||= request.referer
    @comment=Comment.find(params[:id])
    @comment.destroy
    redirect_to session.delete(:return_to)
    # redirect_to root_path, status: :see_other
  end


  private
  def comment_params
    params.require(:comment).permit(:body)
  end
end
