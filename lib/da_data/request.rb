require 'http'
require 'oj'

module DaData
  class Request
    BASE = 'https://suggestions.dadata.ru/suggestions/api/4_1'.freeze

    API_METHOD_MAP = {
      suggest_address: 'rs/suggest/address',
      find_by_id: 'rs/findById/address'
    }.freeze

    CONTENT_TYPES = {
      xml: 'application/xml',
      json: 'application/json'
    }.freeze

    attr_reader :api_method, :content_type, :client, :response

    def self.method_missing(method_name, query, params = {})
      super unless method_name.in? API_METHOD_MAP.keys

      new(method_name).query(query, params)
    end

    def initialize(api_method, content_type = :json)
      @api_method = api_method.to_sym
      @content_type = CONTENT_TYPES[content_type.to_sym]
      @client = HTTP.auth("Token #{DaData.configuration.auth_token}")
                    .headers({ 'Content-Type': 'application/json', 'Accept': @content_type })
    end

    def query(query_string, params = {})
      query_params = DaData.configuration.default_params.merge(query: query_string).merge(params)
      @response = client.post(build_url, json: query_params)
      parse_response(@response.to_s)
    end

    private

    def parse_response(response_string)
      case content_type
      when /json/
        ::Oj.load(response_string)
      when /xml/
        ::Ox.load(response_string, mode: :hash)
      else
        response_string
      end
    end

    def build_url
      "#{BASE}/#{API_METHOD_MAP[api_method]}"
    end
  end
end
