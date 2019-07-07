# frozen_string_literal: true

class UsersController < ApplicationController
  respond_to :html

  def index
    @users = User.order(:slug).page(params[:page])
  end

  def show
    @user = User.friendly.find(params[:id]).decorate
    @owned_events = @user.owner_of_events.visible_by_user(current_user)
    @attended_events = @user.member_in_events.visible_by_user(current_user)
    respond_with @user
  end
end
