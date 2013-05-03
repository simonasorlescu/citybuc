class MediaController < ApplicationController
  def index
    event = Event.find(params[:event_id])
    media = event.get_event_media
    respond_with(media)
  end

  def show
    @medium = Medium.find(params[:id])

    respond_with(@medium)
  end
end
