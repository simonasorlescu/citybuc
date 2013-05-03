class LocationsController < ApplicationController
  def index
    @locations = Location.all
    respond_with(@locations)
  end

  def subscribed_to
    user = User.find(params[:user_id])
    p params
    if params[:subscribed_to] == 'locations'
      locations = user.locations
      p locations
      respond_with(locations)
      #loc = Location.find(params[:location_id])
      #subs = loc.subscriptions
    elsif params[:subscribed_to] == 'categories'
      categories = user.categories
      p categories
      respond_with(categories)
      #cat = Category.find(params[:category_id])
      #subs = cat.subscriptions
    end
  end

  def show
    @location = Location.find(params[:id])
    @location["average rating"] = @location.get_avg_rating.to_f
    respond_with(@location)
  end
end
