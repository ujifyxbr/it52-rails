require 'icalendar'

class EventsController < ApplicationController
  respond_to :html
  responders :flash

  before_action :set_event, only: [:show, :edit, :destroy, :update, :publish, :cancel_publication]
  before_action :check_actual_slug, only: :show
  load_resource param_method: :event_params
  before_action :define_meta_tags, only: :show
  before_action :set_organizer, only: :create
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
      format.ics { render text: Calendar.new(@all_events).to_ical }
    end
  end

  def show
    @event = @event.decorate
    flash[:warning] = t('.waiting_for_approval') unless @event.published?
    respond_to do |format|
      format.html { respond_with @event }
      format.ics { render text: Calendar.new(@event).to_ical }
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
      description: @event.decorate.description,
      canonical: event_url(@event),
      publisher: Figaro.env.mailing_host,
      author: user_url(@event.organizer),
      og: {
        title: :title,
        url: :canonical,
        description: :description,
        image: @event.title_image.square_500.url
      }
    })
  end

  def check_actual_slug
    redirect_to @event, status: :moved_permanently if request.path != event_path(@event)
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
