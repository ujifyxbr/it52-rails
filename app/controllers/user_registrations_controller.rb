class UserRegistrationsController < ApplicationController
  respond_to :html

  def new
    respond_with @user = User.new
  end

  def create
    @new_user = User.create(user_params)

    if @new_user.persisted?
      auto_login(@new_user)
      redirect_back_or_to(root_path)
    else
      @user = User.new
      render 'user_sessions/new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
