require 'spec_helper'

describe UsersController do

  before do
    @user = create(:user)
  end

  describe "GET index" do
    before do
      @location = create(:location)
      get :index, format: :json
    end

    it "is successful" do
      response.should be_success
    end

    it "assigns all users to @users" do
      assigns(:users).should eq([@user])
    end

    it "returns correct JSON" do
      body = JSON.parse(response.body)
      body.should include('user')
      response.body.should == @users.to_json
    end

    # it "displays all users" do
    #   visit users_url
    #   page.should have_content 'database'
    # end
  end

  describe "GET show" do
    before do
      get :show, format: :json, id: @user
    end

    it "is successful" do
      response.should be_success
    end

    it "assigns the requested user to @user" do
      assigns(:user).should eq(@user)
    end

    it "returns the correct user when correct id is passed" do
      body = JSON.parse(response.body)
      body["id"].should == @user.id
      body["username"].should == @user.username
    end

    it "renders the correct JSON" do
      response.body.should == @user.to_json
    end
  end

  describe "GET new" do
    it "assigns a new user to @user" do
      get :new, format: :json
      assigns(:user).should be_a_new(User)
    end
  end

  describe "GET edit" do
    it "assigns the requested user to @user" do
      user = create(:user)
      get :edit, id: user
      assigns(:user).should eq(user)
    end
  end

  describe "POST create" do
    context "with valid attributes" do
      it "is successful" do
        post :create, user: attributes_for(:user)
        response.should be_success
      end

      it "creates a new user" do
        expect{
          post :create, user: attributes_for(:user)
        }.to change(User,:count).by(1)
      end

      it "sets @user" do
        post :create, user: attributes_for(:user)
        assigns(:user).email.should == @user[:email]
      end

      it "assigns a newly created user to @user" do
        post :create, user: attributes_for(:user)
        assigns(:user).should be_a(User)
        assigns(:user).should be_persisted
      end

      it "returns created user in json" do
        post :create, user: attributes_for(:user)
        body = JSON.parse(response.body)
        body["email"].should == @user[:email].to_json
      end

      it "redirects to the created user" do
        post :create, user: attributes_for(:user)
        response.should redirect_to User.last
      end

      # it "redirects to the home page upon save" do
      #   post :create, user: attributes_for(:user)
      #   response.should redirect_to root_url
      # end
    end

    context "with invalid attributes" do
      it "does not save the new user" do
        expect{
          post :create, user: attributes_for(:invalid_user)
        }.to_not change(User,:count)
      end

      it "re-renders the new method" do
        post :create, user: attributes_for(:invalid_user)
        response.should render_template :new
      end
    end
  end

  describe 'PUT update' do
    before :each do
      @user = create(:user, username: "Lawrence")
    end

    context "valid attributes" do
      it "locates the requested @user" do
        put :update, id: @user, user: attributes_for(:user)
        assigns(:user).should eq(@user)
      end

      it "changes @user's attributes" do
        put :update, id: @user, user: attributes_for(:user, username: "Larry")
        @user.reload
        @user.username.should eq("Larry")
      end

      it "redirects to the updated user" do
        put :update, id: @user, user: attributes_for(:user)
        response.should redirect_to @user
      end
    end

    context "invalid attributes" do
      it "locates the requested @user" do
        put :update, id: @user, user: attributes_for(:invalid_user)
        assigns(:user).should eq(@user)
      end

      it "does not change @user's attributes" do
        put :update, id: @user, user: attributes_for(:user, username: nil)
        @user.reload
        @user.username.should_not eq("Larry")
        @user.username.should eq("Lawrence")
      end

      it "re-renders the edit method" do
        put :update, id: @user, user: attributes_for(:invalid_user)
        response.should render_template :edit
      end
    end
  end

  describe 'DELETE destroy' do
    it "deletes the user" do
      expect{
        delete :destroy, id: @user
      }.to change(User,:count).by(-1)
    end

    it "redirects to users#index" do
      delete :destroy, id: @user
      response.should redirect_to users_url
    end
  end
end
