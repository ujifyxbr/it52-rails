class TelegramMessage
  include HTTParty
  base_uri 'api.telegram.org'

  API_KEY = Figaro.env.telegram_bot_token
  CHAT_ID = Figaro.env.telegram_chat_id

  def initialize(text)
    @options = { query: {
      chat_id: "@#{CHAT_ID}",
      text: text,
      parse_mode: 'Markdown'
    }}
    @bot_path = "bot#{API_KEY}"
  end

  def send!
    @result = self.class.get("/#{@bot_path}/sendMessage", @options)
  end
end
