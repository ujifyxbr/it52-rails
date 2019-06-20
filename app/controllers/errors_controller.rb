class ErrorsController < ApplicationController
  layout false

  def error_404; end

  def image
    redirect_to build_attachment_path, status: :permanent_redirect
  end

  private

  def build_attachment_path
    production_prefix = 'https://assets.it52.info'
    [production_prefix, request.path.gsub('images/aws_host/uploads/development', 'uploads/production')].join
  end
end
