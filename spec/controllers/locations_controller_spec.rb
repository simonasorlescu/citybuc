require 'spec_helper'

describe LocationsController do

  before do
    @location = create(:location)
  end

  describe "GET index" do
    before do
      get :index, format: :json
    end

    it "is successful" do
      response.should be_success
    end

    it "assigns all locations to @locations" do
      assigns(:locations).should eq([@location])
    end

    it "returns correct JSON" do
      body = JSON.parse(response.body)
      body.should include @location.address
      body.should == assigns(:locations).to_json
    end
  end

  describe "GET show" do
    before do
      get :show, format: :json, id: @location
    end

    it "is successful" do
      response.should be_success
    end

    it "assigns the requested location to @location" do
      assigns(:location).should eq(@location)
    end

    it "returns the correct location when correct id is passed" do
      body = JSON.parse(response.body)
      body["id"].should == @location.id
    end

    it "renders the correct JSON" do
      body.should == @location.to_json
    end
  end
end
