class PagesController < ApplicationController
  include HighVoltage::StaticPage

  before_action :set_telegram_domain, if: -> { params[:id] == 'communities' }

  private

  def set_telegram_domain
    @telegram_domain = ENV.fetch('telegram_domain') { 't.me' }
  end
end
