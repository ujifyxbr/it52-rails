# frozen_string_literal: true

module Telegram
  API_KEY = ENV.fetch('telegram_bot_token') { 'telegram_bot_token' }
  CHAT_ID = ENV.fetch('telegram_chat_id') { 'telegram_chat_id' }
  BASE_URI = 'https://api.telegram.org'

  class ParseError < StandardError; end
  class LongMessageError < StandardError; end
  class Error < StandardError; end
end
