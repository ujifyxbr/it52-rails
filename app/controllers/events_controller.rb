require 'icalendar'

class EventsController < ApplicationController
  respond_to :html
  responders :flash

  load_resource param_method: :event_params
  before_action :set_organizer, only: :create
  authorize_resource

  has_scope :ordered_desc, type: :boolean, allow_blank: true, default: true

  def index
    @events = apply_scopes(@events).decorate
    respond_with @events
  end

  def show
    @event = @event.decorate
    flash[:warning] = t('.waiting_for_approval') unless @event.published?
    respond_to do |format|
      format.html { respond_with @event }
      format.ics {
        calendar = Icalendar::Calendar.new
        calendar.add_event(@event.to_ics)
        calendar.publish
        render :text => calendar.to_ical
      }
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

  def set_organizer
    @event.organizer = current_user || nil
  end

  def event_params
    permitted_attrs = [
      :title,
      :description,
      :started_at,
      :title_image,
      :place
    ]
    params.require(:event).permit(*permitted_attrs)
  end
end
