class MediaController < ApplicationController
  def index
    if params[:event_id]
      event = Event.find(params[:event_id])
      media = event.get_event_media
    elsif params[:location_id]
      location = Location.find(params[:location_id])
      media = location.get_location_media
    end
    respond_with(media)
  end

  def show
    @medium = Medium.find(params[:id])
    respond_with(@medium)
  end
end
