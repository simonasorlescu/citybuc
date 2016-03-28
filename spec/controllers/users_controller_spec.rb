require 'spec_helper'

describe UsersController do
  describe "GET index" do
    before do
      @user = create(:user)
      get :index, format: :json
    end

    it "is successful" do
      response.should be_success
    end

    it "assigns all users to @users" do
      assigns(:users).should eq [@user]
    end

    it "returns correct JSON" do
      response.body.should == assigns(:users).to_json
    end

    after do
      @user.destroy
    end
  end

  describe "GET users subscribed to location" do
    before do
      @user = create(:user)
      @location = create(:location)
      @subscription = create(:subscription, user: @user, location: @location)
      get :users_subscribed_to_location, format: :json, id: @location.id
    end

    it "is successful" do
      response.should be_success
    end

    it "returns correct JSON" do
      body = JSON.parse response.body
      body.length.should == 1
      actual = body[0]
      expected = JSON.parse @user.to_json
      actual.should eq expected
    end

    after do
      @user.destroy
    end
  end

  describe "GET users subscribed to category" do
    before do
      @user = create(:user)
      @category = create(:category)
      @subscription = create(:subscription, user: @user, category: @category)
      get :users_subscribed_to_category, format: :json, id: @category.id
    end

    it "is successful" do
      response.should be_success
    end

    it "returns correct JSON" do
      body = JSON.parse response.body
      body.length.should == 1
      actual = body[0]
      expected = JSON.parse @user.to_json
      actual.should eq expected
    end

    after do
      @user.destroy
    end
  end

  describe "GET users subscribed to event" do
    before do
      @user = create(:user)
      @location = create(:location)
      @event = create(:event, location: @location)
      @subscription = create(:subscription, user: @user, location: @location)
      get :users_subscribed_to_event, format: :json, id: @event.id
    end

    it "is successful" do
      response.should be_success
    end

    it "returns correct JSON" do
      body = JSON.parse response.body
      body.length.should == 1
      actual = body[0]
      expected = JSON.parse @user.to_json
      actual.should eq expected
    end

    after do
      @user.destroy
    end
  end

  describe "GET show" do
    before do
      @user = create(:user)
      get :show, format: :json, id: @user
    end

    it "is successful" do
      response.should be_success
    end

    it "assigns the requested user to @user" do
      assigns(:user).should eq @user
    end

    it "renders correct JSON" do
      body = JSON.parse(response.body)
      body["id"].should == @user.id
      body["username"].should == @user.username
      response.body.should == @user.to_json
    end

    after do
      @user.destroy
    end
  end

  describe "GET new" do
    it "assigns a new user to @user" do
      get :new, format: :json
      assigns(:user).should be_a_new User
    end

    after do
      users = User.all
      for user in users
        user.destroy
      end
    end
  end

  describe "GET edit" do
    it "assigns the requested user to @user" do
      @user = create(:user)
      get :edit, id: @user
      assigns(:user).should eq @user
    end

    after do
      @user.destroy
    end
  end

  describe "POST create" do
    context "with valid attributes" do
      it "is successful" do
        post :create, format: :json, user: attributes_for(:user)
        response.should be_success
      end

      it "creates a new user" do
        expect{
          post :create, format: :json, user: attributes_for(:user)
        }.to change(User,:count).by(1)
      end

      it "sets @user" do
        post :create, format: :json, user: attributes_for(:user)
        users = User.all
        users.count.should == 1
        assigns(:user).should == users[0]
      end

      it "assigns a newly created user to @user" do
        post :create, format: :json, user: attributes_for(:user)
        assigns(:user).should be_a User
        assigns(:user).should be_persisted
      end

      it "returns created user in json" do
        post :create, format: :json, user: attributes_for(:user)
        users = User.all
        response.body.should == users[0].to_json
        # body["email"].should == @user[:email]
        # response.body.should == @user.to_json
      end

      after do
        users = User.all
        for user in users
          user.destroy
        end
      end
    end

    context "with invalid attributes" do
      it "does not save the new user" do
        expect{
          post :create, user: attributes_for(:invalid_user)
        }.to_not change(User,:count)
      end

      # it "re-renders the new method" do
      #   post :create, user: attributes_for(:invalid_user)
      #   response.body.should include @user.errors.to_json
      # end
    end

    after do
      users = User.all
      for user in users
        user.destroy
      end
    end
  end

  describe 'PUT update' do
    before do
      @user = create(:user, username: "Lawrence")
    end

    context "valid attributes" do
      it "locates the requested @user" do
        put :update, format: :json, id: @user, user: attributes_for(:user)
        assigns(:user).should eq @user
      end

      it "changes @user's attributes" do
        put :update, format: :json, id: @user, user: attributes_for(:user, username: "Larry")
        @user.reload
        @user.username.should eq "Larry"
      end

      it "redirects to the updated user" do
        put :update, format: :json, id: @user, user: attributes_for(:user)
        response.body.should == " "
        # response.should redirect_to @user
      end
    end

    context "invalid attributes" do
      before do
        put :update, format: :json, id: @user, user: attributes_for(:invalid_user)
      end

      it "locates the requested @user" do
        assigns(:user).should eq @user
      end

      it "does not change @user's attributes" do
        @user.reload
        @user.username.should eq "Lawrence"
        # response.body.should == @user.errors
      end
    end

    after do
      @user.destroy
    end
  end

  describe 'DELETE destroy' do
    it "deletes the user" do
      @user = create(:user)
      expect{
        delete :destroy, id: @user
      }.to change(User,:count).by(-1)
      response.body.should == " "
    end

    after do
      @user.destroy
    end
  end
end
