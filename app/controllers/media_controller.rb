class MediaController < ApplicationController
  def index
    event = Event.find(params[:event_id])
    media = event.getEventMedia
    respond_with(media)
  end

  def show
    @medium = Medium.find(params[:id])

    respond_with(@medium)
  end
end
