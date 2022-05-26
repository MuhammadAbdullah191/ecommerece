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

    redirect_to product_path(@product)
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end
end
