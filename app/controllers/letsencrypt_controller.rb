class LetsencryptController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def approve
    render text: Figaro.env.letsencrypt_token
  end
end
