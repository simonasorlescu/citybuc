class ReviewsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]

  def index
    if params[:event_id]
      p 'intra event'
      event = Event.find(params[:event_id])
      reviews = event.get_event_reviews
    elsif params[:location_id]
      p 'intra location'
      location = Location.find(params[:location_id])
      reviews = location.get_location_reviews
    elsif params[:user_id]
      p 'intra user'
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
  end

  def create
    @review = Review.new(params[:review])

    respond_to do |format|
      if @review.save
        format.json { render json: @review, status: :created, location: @review }
      else
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @review = Review.find(params[:id])

    respond_to do |format|
      if @review.update_attributes(params[:review])
        format.json { head :no_content }
      else
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end
end
