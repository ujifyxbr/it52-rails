class SitemapsController < ApplicationController
  respond_to :xml

  def index
    @events = Event.published
    @pages = HighVoltage.page_ids
  end
end
