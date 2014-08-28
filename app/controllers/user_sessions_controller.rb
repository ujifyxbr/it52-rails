class UserSessionsController < ApplicationController
  before_action :set_new_user, only: [:new, :create]

  def create
    @user = login(params[:email], params[:password], params[:remember_me])
    if @user
      redirect_back_or_to(root_path)
    else
      flash.now[:danger] = t('.login_failed_message')
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to root_path
  end

  private

  def set_new_user
    @user = User.new
    @new_user = @user
  end
end
