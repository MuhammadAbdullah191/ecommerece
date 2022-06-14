# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[show index]
  def index; end

  def show
    @user = User.find(params[:id])
  end
end
