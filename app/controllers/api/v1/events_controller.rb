module Api
  module V1
    class EventsController < ApiController
      load_and_authorize_resource

      def index
        year = params[:year].present? ? params[:year].to_i : Time.now.year
        @response_object = Event.held_in(year).decorate
        render render_options
      end

      def show
        @response_object = Event.find(params[:id]).decorate
        render render_options
      end
    end
  end
end
