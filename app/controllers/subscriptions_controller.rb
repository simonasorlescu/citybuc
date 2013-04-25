class SubscriptionsController < ApplicationController
  before_filter :authenticate_user!

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

    respond_to do |format|
      if @subscription.save
        format.json { render json: @subscription, status: :created, location: @subscription }
      else
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @subscription = Subscription.find(params[:id])
    @subscription.destroy

    respond_to do |format|
      # format.html { redirect_to subscriptions_url }
      format.json { head :no_content }
    end
  end
end
