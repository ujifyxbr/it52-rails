# frozen_string_literal: true

require_dependency 'my'

class ApplicationController < ActionController::Base
  # include Styx::Initializer

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery prepend: true, with: :exception

  add_flash_types :error, :failure, :success, :alert

  before_action :define_common_meta_tags, only: %i[index show new edit]
  before_action :authenticate_user!, if: -> { authenticated_path? }

  rescue_from CanCan::AccessDenied do |exception|
    redirect_back(fallback_location: root_path, error: exception.message)
  end

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] ||
      stored_location_for(resource) ||
      root_path
  end

  private

  def define_common_meta_tags
    set_meta_tags(
      site: t(:app_name),
      description: t(:app_description),
      keywords: t(:app_keywords),
      reverse: true,
      charset: 'utf-8',
      og: {
        site_name: :site,
        locale: 'ru_RU'
      }
    )
  end

  def authenticated_path?
    controller_path.split('/').first == 'my' || new_event_path == request.original_fullpath
  end
end
