require 'icalendar'

class EventsController < ApplicationController
  respond_to :html
  responders :flash
  before_action :set_allow_cors_headers
  before_action :set_event, only: [:show, :edit, :destroy, :update, :publish, :cancel_publication]
  load_resource param_method: :event_params
  before_action :set_organizer, only: :create
  authorize_resource

  has_scope :ordered_desc, type: :boolean, allow_blank: true, default: true

  def set_allow_cors_headers
    headers['Access-Control-Allow-Origin']    = '*'
    headers['Access-Control-Allow-Methods']   = 'GET'
    headers['Access-Control-Request-Method']  = 'OPTIONS'
    headers['Access-Control-Allow-Headers']   = 'Content-Type'
  end

  def index
    @events = Event.visible_by_user(current_user).future.decorate
    @past_events = Event.visible_by_user(current_user).past.decorate
    @rss_events = Event.published.future.order(published_at: :asc).decorate
    @all_events = Event.published.order(started_at: :asc)
    respond_to do |format|
      format.json { render json: @all_events.to_json(:include => { :organizer => { :only => [:nickname, :first_name, :last_name] }}) }
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
    params.require(:event).permit(*permitted_attrs)
  end
end
