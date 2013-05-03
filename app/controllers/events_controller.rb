class EventsController < ApplicationController
  def index
    @events = Event.all
    respond_with(@events)
  end

  def show
    @event = Event.find(params[:id])
    @event["average rating"] = @event.get_avg_rating.to_f
    respond_with(@event)
  end
end
