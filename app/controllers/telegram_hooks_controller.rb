class TelegramHooksController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def process
    Rails.logger.error params.inspect
    Rails.logger.error JSON.parse(params.inspect)
    render nothing: true, status: :ok
  end
end
