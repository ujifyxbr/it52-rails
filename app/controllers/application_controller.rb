class ApplicationController < ActionController::Base
  include Styx::Initializer

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  add_flash_types :error, :failure, :success, :alert

  before_filter :authenticate_user!, if: -> { profile_path? }

  def after_sign_in_path_for(resource)
     request.env['omniauth.origin'] ||
     stored_location_for(resource) ||
     root_path
  end

  private

  def profile_path?
    controller_namespace == My
  end

  def controller_namespace
    self.class.parent
  end
end
