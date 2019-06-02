module Api
  module V2
    class ApiController < ActionController::Base
      before_action :set_allow_cors_headers

      protected

      def set_allow_cors_headers
        headers['Access-Control-Allow-Origin']    = '*'
        headers['Access-Control-Allow-Methods']   = 'GET'
        headers['Access-Control-Request-Method']  = 'OPTIONS'
        headers['Access-Control-Allow-Headers']   = 'Content-Type'
      end
    end
  end
end