# frozen_string_literal: true

class CommentsController < ApplicationController
  def index; end

  def show
    @comment = Comment.find(params[:id])
  end

  def create
    @product = Product.find(params[:product_id])
    @comment = @product.comments.new(comment_params)
    authorize @comment
    if user_signed_in?
      @comment = @product.comments.new(comment_params)
      @comment.user_id = current_user.id
      @comment.commenter = current_user.email
      @comment.save
    end
  end

  def edit
    session[:return_to] ||= request.referer
    @comment = Comment.find(params[:id])
    authorize @comment
  end

  def update
    @comment = Comment.find(params[:id])

    if @comment.update(comment_params)
      redirect_to session.delete(:return_to)
    else
      render :edit
    end
  end

  def destroy
    session[:return_to] ||= request.referer
    @comment = Comment.find(params[:id])
    authorize @comment
    @comment.destroy
    redirect_to session.delete(:return_to)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
