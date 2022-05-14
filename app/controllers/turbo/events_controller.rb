# frozen_string_literal: true

module Turbo
  class EventsController < ApplicationController
    respond_to :rss

    def index
      @events = Event.includes(:event_participations, :participants, :organizer)
                     .order(published_at: :asc)
                     .published.decorate
    end
  end
end
