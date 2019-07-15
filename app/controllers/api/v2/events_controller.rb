# frozen_string_literal: true

module Api
  module V2
    class EventsController < ApiController
      before_action :prepare_model

      def index
        @events = @model.order(published_at: :desc)
        @events = @events.tagged_with(params[:tag]) if params[:tag].present?
        @events = @events.page(params[:page] || 1)
        options = { include: %i[organizer],
                    is_collection: true,
                    params: { action: action_name },
                    links: { self: events_url(page: @events.current_page),
                             next: events_url(page: @events.next_page),
                             prev: events_url(page: @events.prev_page) },
                    meta: { total_count: @events.total_count,
                            total_pages: @events.total_pages } }
        render json: ::V2::EventSerializer.new(@events, options).serializable_hash
      end

      def show
        @event = @model.find(params[:id])
        options = { include: %i[organizer participants],
                    is_collection: false,
                    params: { action: action_name },
                    links: { self: event_url(@event) } }
        render json: ::V2::EventSerializer.new(@event, options).serializable_hash
      end

      private

      def prepare_model
        @model = Event.includes(:organizer, :participants).published
      end
    end
  end
end
