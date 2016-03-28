require 'spec_helper'

describe LocationsController do
  describe "GET index" do
    before do
      @location = create(:location)
      get :index, format: :json
    end

    it "is successful" do
      response.should be_success
    end

    it "assigns all locations to @locations" do
      assigns(:locations).should eq [@location]
    end

    it "returns correct JSON" do
      response.body.should == assigns(:locations).to_json
    end

    after do
      locations = Location.all
      for location in locations
        location.destroy
      end
    end
  end

  describe "GET show" do
    before do
      @location = create(:location)
      get :show, format: :json, id: @location
    end

    it "is successful" do
      response.should be_success
    end

    it "assigns the requested location to @location" do
      assigns(:location).should eq @location
    end

    it "returns correct JSON" do
      body = JSON.parse(response.body)
      body["id"].should == @location.id
      response.body.should == @location.to_json
    end

    after do
      locations = Location.all
      for location in locations
        location.destroy
      end
    end
  end

  describe "user is subscribed to" do
    before do
      @user = create(:user)
      @location = create(:location)
    end

    context "locations" do
      before do
        @subscription = create(:subscription, user: @user, location: @location)
        get :subscribed_to, format: :json, user_id: @user.id, subscribed_to: 'locations'
      end

      it "is successful" do
        response.should be_success
      end

      it "returns correct JSON" do
        body = JSON.parse response.body
        body.length.should == 1
        actual = body[0]
        expected = JSON.parse @location.to_json
        actual.should eq expected
      end
    end

    context "categories" do
      before do
        @category = create(:category)
        @subscription = create(:subscription, user: @user, category: @category)
        get :subscribed_to, format: :json, user_id: @user.id, subscribed_to: 'categories'
      end

      it "is successful" do
        response.should be_success
      end

      it "returns correct JSON" do
        body = JSON.parse response.body
        body.length.should == 1
        actual = body[0]
        expected = JSON.parse @category.to_json
        actual.should eq expected
      end
    end

    after do
      @user.destroy
      @location.destroy
    end
  end
end
