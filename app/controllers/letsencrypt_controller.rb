# frozen_string_literal: true

class LetsencryptController < ApplicationController
  # skip_before_action :verify_authenticity_token

  def approve
    render text: ENV.fetch('letsencrypt_token') { 'letsencrypt_token' }
  end
end
