# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authoriz_comment, only: [:create]
  def index
    @comment = Comment.where(product_id: params[:product_id])
    render json: @comment
  end

  def create
    @comment = @product.comments.new(comment_params)
    @comment.user_id = current_user.id
    @comment.commenter = current_user.email
    @comment.save
    render json: @comment
  end

  def edit
    session[:return_to] ||= request.referer
    @comment = Comment.find(params[:id])
    authorize @comment
  end

  def update
    @comment = Comment.find(params[:id])
    authorize @comment
    if @comment.update(comment_params)
      redirect_to session.delete(:return_to) unless session[:return_to].nil?
    else
      render '_edit'
    end
  end

  def destroy
    session[:return_to] ||= request.referer
    @comment = Comment.find(params[:id])
    authorize @comment
    @comment.destroy
    redirect_to session.delete(:return_to) unless session[:return_to].nil?
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def authoriz_comment
    @product = Product.find(params[:product_id])
    @comment = @product.comments.new(comment_params)
    authorize @comment
  end
end
