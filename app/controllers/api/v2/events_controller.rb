# coding: utf-8
module Api
  module V2
    class EventsController < ApiController
      before_action :prepare_model

      def index
        @events = @model.published.order(published_at: :desc)
        @events = @events.tagged_with(params[:tag]) if params[:tag].present?
        @events = @events.page(params[:page] || 1).per(PAGINATE_PER)
        options = {
          links: {
            self: events_url(page: @events.current_page),
            next: events_url(page: @events.next_page),
            prev: events_url(page: @events.prev_page),
          },
          meta: {
            total_count: @events.total_count,
            total_pages: @events.total_pages
          }
        }
        render json: ::V2::EventSerializer.new(@events, options).serializable_hash
      end

      private

      def prepare_model
        @model = Event.includes(:participants, participants: :authentications)
      end
    end
  end
end
