class TelegramHooksController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def process
    Rails.logger.info bot_request_params.inspect
    render nothing: true, status: :ok
  end

  private

  def bot_request_params
    params.permit!
  end
end
