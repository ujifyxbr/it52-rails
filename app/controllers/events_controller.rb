require 'icalendar'

class EventsController < ApplicationController
  respond_to :html
  responders :flash

  before_action :set_event, only: [:show, :edit, :destroy, :update, :publish, :cancel_publication]
  before_action :check_actual_slug, only: :show
  before_action :define_meta_tags, only: [:show, :edit]
  before_action :set_organizer, only: :create

  load_resource param_method: :event_params
  authorize_resource

  has_scope :ordered_desc, type: :boolean, allow_blank: true, default: true

  def index
    model = Event.includes(:event_participations, :participants, :organizer)
    @past = request.path.include?('past')
    @events = model.visible_by_user(current_user).future.decorate
    @events = model.visible_by_user(current_user).past.decorate if @past
    @rss_events = model.published.future.order(published_at: :asc).decorate
    @all_events = model.published.order(started_at: :asc)
    respond_to do |format|
      format.json { render json: @all_events.to_json }
      format.html
      format.atom
      format.ics { render body: Calendar.new(@all_events).to_ical }
    end
  end

  def show
    @event = @event.decorate
    flash[:warning] = t('.waiting_for_approval') unless @event.published?
    respond_to do |format|
      format.html { respond_with @event }
      format.ics { render body: Calendar.new(@event).to_ical, mime_type: Mime::Type.lookup("text/calendar") }
    end
    #respond_with @event
  end

  def new
    respond_with @event
  end

  def create
    @event.save
    respond_with @event
  end

  def edit
    respond_with @event
  end

  def destroy
    @event.destroy
    redirect_to :index
  end

  def update
    @event.update_attributes event_params
    respond_with @event
  end

  def publish
    @event.publish!
    flash[:success] = t('.success_message')
    redirect_to action: :show
  end

  def cancel_publication
    @event.cancel_publication!
    flash[:success] = t('.success_message')
    redirect_to action: :show
  end

  private

  def define_meta_tags
    set_meta_tags({
      title: [l(@event.started_at, format: :date_time_full), @event.title],
      description: @event.decorate.simple_description,
      canonical: event_url(@event),
      publisher: Figaro.env.mailing_host,
      author: user_url(@event.organizer),
      og: {
        title: :title,
        url: :canonical,
        description: :description,
        image: @event.title_image.fb_1200.url
      }
    })

    @structured_data = {
      "@context": "http://schema.org",
      "@type": "Event",
      name: @event.title,
      startDate: @event.started_at.iso8601,
      url: event_url(@event),
      image:  @event.title_image.square_500.url,
      description: @event.decorate.simple_description,
      # canonical: event_url(@event),
      # publisher: Figaro.env.mailing_host,
      performer: {
        "@type": "PerformingGroup",
        legalName: Figaro.env.mailing_host,
        name: Figaro.env.mailing_host,
        url: "https://#{Figaro.env.mailing_host}"
      },
      location: {
        "@type": "Place",
        name: @event.place,
        address: @event.place
      },
      organizer: {
        "@type": "Person",
        url: user_url(@event.organizer),
        name: @event.organizer.to_s
      }
    }
  end

  def check_actual_slug
    slug_correct = request.path == event_path(@event, format: request.format.symbol.to_s)
    slug_correct = request.path == event_path(@event) if request.format.symbol == :html
    redirect_to @event, status: :moved_permanently unless slug_correct
  end

  def set_event
    @event = Event.friendly.find(params[:id])
  end

  def set_organizer
    @event.organizer = current_user || nil
  end

  def event_params
    permitted_attrs = [
      :title,
      :description,
      :started_at,
      :title_image,
      :place,
      :title_image_cache,
      :location
    ]
    params[:event].delete(:location) if params[:event][:location].blank?
    params.require(:event).permit(*permitted_attrs)
  end
end
