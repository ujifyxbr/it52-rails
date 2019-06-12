module DaData
  class Configuration
    attr_accessor :auth_token, :auth_secret, :default_params

    def initialize
      @auth_token  = ENV.fetch('DADATA_AUTH_TOKEN') { nil }
      @auth_secret = ENV.fetch('DADATA_AUTH_SECRET') { nil }
      @default_params = {}
    end
  end
end
