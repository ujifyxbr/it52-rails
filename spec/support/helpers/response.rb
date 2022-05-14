# frozen_string_literal: true

module Helpers
  module Response
    def response_body
      JSON.parse(response.body)
    rescue JSON::ParserError
      response.body
    end
  end
end
