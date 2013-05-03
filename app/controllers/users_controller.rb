class UsersController < ApplicationController
  def index
    @users = User.all
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
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])

    # if @user.save
    #   sign_in @user
    #   flash[:success] = "Welcome to City Guide Bucharest!"
    #   redirect_to @user
    # else
    #   render 'new'
    # end

    respond_to do |format|
      if @user.save
        # format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        # format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        # format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        # format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      # format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

end
