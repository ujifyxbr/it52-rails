class TelegramMessage
  require 'json'
  require 'net/http'
  require 'net/http/post/multipart'

  API_KEY = Figaro.env.telegram_bot_token
  CHAT_ID = Figaro.env.telegram_chat_id

  BASE_URI = 'https://api.telegram.org'
  MAX_MESSAGE_LENGTH = 4096
  TYPES_MAP = {
    message: 'sendMessage'
  }

  attr_reader :response, :uri, :query, :result

  def initialize(type)
    raise ArgumentError, "Unknown message type '#{type}'. Acceptable types are #{TYPES_MAP.keys.to_sentence}." unless TYPES_MAP.has_key?(type)

    @query = { chat_id: "@#{CHAT_ID}" }
    @uri = URI"#{BASE_URI}/bot#{API_KEY}/#{TYPES_MAP[type]}"
  end

  def send_message(text)
    @query.merge!({
      text: normalize_text(text),
      parse_mode: 'Markdown'
    })
    post!
  end

  private

  def post!
    @response = Net::HTTP.post_form(@uri, @query)
    @result = JSON.parse(@response.body).to_h
    handle_error() unless @result['ok']
    @result
  end

  def normalize_text(text)
    text.gsub(/\*\*/, '_').gsub(/^\*\s/, '- ').truncate(MAX_MESSAGE_LENGTH, separator: /\s/)
  end

  def handle_error
    klass = TelegramLongMessageError if @result['description'] == "Message is too long"
    klass = TelegramParseError if @result['description'] =~ /Can\'t parse message/
    klass ||= TelegramError
    raise klass, @result['description']
  end
end

class TelegramParseError < StandardError; end
class TelegramLongMessageError < StandardError; end
class TelegramError < StandardError; end
