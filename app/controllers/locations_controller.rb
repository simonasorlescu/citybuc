class LocationsController < ApplicationController
  def index
    @locations = Location.all
    respond_with(@locations)
  end

  def show
    @location = Location.find(params[:id])
    respond_with(@location)
  end

  def subscribed_to
    user = User.find(params[:user_id])
    if params[:subscribed_to] == 'locations'
      locations = user.locations
      respond_with(locations)
      #loc = Location.find(params[:location_id])
      #subs = loc.subscriptions
    elsif params[:subscribed_to] == 'categories'
      categories = user.categories
      respond_with(categories)
      #cat = Category.find(params[:category_id])
      #subs = cat.subscriptions
    end
  end
end
