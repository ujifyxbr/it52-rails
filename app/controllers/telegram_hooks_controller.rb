class TelegramHooksController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def process_bot_request
    req = Telegram::Request.new bot_request_params
    req.reply!
    render nothing: true, status: :ok
  end

  private

  def bot_request_params
    params.permit!
  end
end
