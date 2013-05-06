class UsersController < ApplicationController
  def index
    @users = User.all
    respond_with(@users)
  end

  def users_subscribed_to_location
    location = Location.find(params[:id])
    users = location.get_all_users_subscribed_to_location
    respond_with(users)
  end

  def users_subscribed_to_category
    category = Category.find(params[:id])
    users = category.get_all_users_subscribed_to_category
    respond_with(users)
  end

  def users_subscribed_to_event
    event = Event.find(params[:id])
    users = event.get_all_users_subscribed_to_event
    respond_with(users)
  end

  def show
    @user = User.find(params[:id])
    respond_with(@user)
  end

  def new
    @user = User.new
    respond_with(@user)
  end

  def edit
    @user = User.find(params[:id])
    respond_with(@user)
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      respond_with(@user, status: :created, location: @user)
    else
      respond_with(@user.errors, status: :unprocessable_entity)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
       head :no_content
    else
      respond_with(@user.errors, status: :unprocessable_entity)
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    head :no_content
  end
end
