class TelegramHooksController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def process(test = nil)
    Rails.logger.error test.inspect
    Rails.logger.error params.inspect
    Rails.logger.error JSON.parse(params.inspect)
    render nothing: true, status: :ok
  end
end
