class UsersController < ApplicationController
  respond_to :html
  responders :flash

  before_filter :set_user, except: [:index, :show]

  def index
    @users = User.all
    respond_with @users
  end

  def show
    @user = current_user
    @user = User.find params[:id] if params[:id]
    respond_with @user
  end

  def update
    @user.update_attributes user_profile_params

    respond_with @user, location: edit_my_profile_path
  end

  private

  def set_user
    @user = current_user
    authorize! :manage, @user
  end

  def user_profile_params
    params.require(:user).permit(:first_name, :last_name, :name, :bio, :avatar_image, :avatar_image_cache)
  end
end
