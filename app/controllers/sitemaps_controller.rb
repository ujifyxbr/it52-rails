# frozen_string_literal: true

class SitemapsController < ApplicationController
  respond_to :xml

  def index
    @events = Event.published
    @startups = Startup.all
    @pages = HighVoltage.page_ids
  end
end
