class UsersController < ApplicationController
  respond_to :html

  def index
    @users = User.order(:slug)
    respond_with @users
  end

  def show
    @user = User.friendly.find(params[:id]).decorate
    respond_with @user
  end
end
