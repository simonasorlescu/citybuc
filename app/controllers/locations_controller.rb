class LocationsController < ApplicationController
  def index
    @locations = Location.all
    respond_with(@locations)
  end

  def subscribed_to
    user = User.find(params[:user_id])
    if params[:subscribed_to] == 'locations'
      loc = user.locations
      respond_with(loc)
      #loc = Location.find(params[:location_id])
      #subs = loc.subscriptions
    elsif params[:subscribed_to] == 'categories'
      cat = user.categories
      respond_with(cat)
      #cat = Category.find(params[:category_id])
      #subs = cat.subscriptions
    end
  end

  def show
    @location = Location.find(params[:id])
    @location["average rating"] = @location.getAvgRating.to_f
    respond_with(@location)
  end
end
