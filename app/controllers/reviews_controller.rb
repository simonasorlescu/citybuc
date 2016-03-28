class ReviewsController < ApplicationController
  # before_filter :authenticate_user!, :except => [:index, :show]

  def index
    if params[:event_id]
      event = Event.find(params[:event_id])
      reviews = event.get_event_reviews
    elsif params[:location_id]
      location = Location.find(params[:location_id])
      reviews = location.get_location_reviews
    elsif params[:user_id]
      user = User.find(params[:user_id])
      reviews = user.get_user_reviews
    end
    respond_with(reviews)
  end

  def show
    @review = Review.find(params[:id])
    respond_with(@review)
  end

  def new
    @review = Review.new
    respond_with(@review)
  end

  def edit
    @review = Review.find(params[:id])
    respond_with(@review)
  end

  def create
    @review = Review.new(params[:review])
    if @review.save
      url = "/users/#{@review.user_id}/reviews/#{@review.id}"
      respond_with(@review, status: :created, location: url)
    else
      respond_with(@review.errors, status: :unprocessable_entity)
    end
  end

  def update
    @review = Review.find(params[:id])
    if @review.update_attributes(params[:review])
      head :no_content
    else
      respond_with(@review.errors, status: :unprocessable_entity)
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    head :no_content
  end
end
