class EventsController < ApplicationController
  def index
    @events = Event.get_events_with_locations
    respond_with(@events)
  end

  def show
    @event = Event.get_event_with_location(params[:id])
    respond_with(@event)
  end

  def events_by_category
    @category = Category.find(params[:id])
    @events = @category.events
    respond_with(@events)
  end
end
