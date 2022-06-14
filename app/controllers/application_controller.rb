# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include CurrentCart
  include Pundit::Authorization
  before_action :set_cart
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_back(fallback_location: root_path)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[email password name city street zip avatar phone])
  end

  def authenticate_user!
    if user_signed_in?
      super
    else
      redirect_to user_session_path, alert: 'Please login to your account to continue'
    end
  end

  def index
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true)
  end

  def show
    @q = Product.ransack(params[:q])
    @products = @q.result(distinct: true)
  end
end
