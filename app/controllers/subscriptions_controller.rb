class SubscriptionsController < ApplicationController
  # before_filter :authenticate_user!

  def index
    @subscriptions = Subscription.all
    respond_with(@subscriptions)
  end

  def show
    @subscription = Subscription.find(params[:id])
    respond_with(@subscription)
  end

  def new
    @subscription = Subscription.new
    respond_with(@subscription)
  end

  def create
    @subscription = Subscription.new(params[:subscription])

    if @subscription.save
      url = "/users/#{@subscription.user_id}/subscriptions/#{@subscription.id}"
      respond_with(@subscription, status: :created, location: url)
    else
      respond_with(@subscription.errors, status: :unprocessable_entity)
    end
  end

  def destroy
    @subscription = Subscription.find(params[:id])
    @subscription.destroy
    head :no_content
  end
end
