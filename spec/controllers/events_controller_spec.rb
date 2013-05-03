require 'spec_helper'

describe EventsController do
  before do
    @event = create(:event)
  end

  describe "GET index" do
    before do
      get :index, format: :json
    end

    it "is successful" do
      response.should be_success
    end

    it "assigns all events to @events" do
      assigns(:events).should eq([@event])
    end

    it "returns correct JSON" do
      body = JSON.parse(response.body)
      body.should include @event
      body.should == assigns(:events).to_json
    end
  end

  describe "GET show" do
    before do
      get :show, format: :json, id: @event
    end

    it "is successful" do
      response.should be_success
    end

    it "assigns the requested event to @event" do
      assigns(:event).should eq(@event)
    end

    it "returns the correct event when correct id is passed" do
      body = JSON.parse(response.body)
      body["id"].should == @event.id
    end

    it "renders the correct JSON" do
      body.should == @event.to_json
    end
  end
end
