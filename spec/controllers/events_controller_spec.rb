require 'spec_helper'

describe EventsController do
  describe "GET index" do
    before do
      @event = create(:event)
      get :index, format: :json
    end

    it "is successful" do
      response.should be_success
    end

    it "assigns all events to @events" do
      assigns(:events).should eq [@event]
    end

    it "returns correct JSON" do
      response.body.should == assigns(:events).to_json
    end

    after do
      events = Event.all
      for event in events
        event.destroy
      end
    end
  end

  describe "GET show" do
    before do
      @event = create(:event)
      get :show, format: :json, id: @event
    end

    it "is successful" do
      response.should be_success
    end

    it "assigns the requested event to @event" do
      assigns(:event).should eq(@event)
    end

    it "returns correct JSON" do
      body = JSON.parse(response.body)
      body["id"].should == @event.id
      body["average_rating"].should == @event.average_rating
      response.body.should == @event.to_json
    end

    after do
      events = Event.all
      for event in events
        event.destroy
      end
    end
  end
end
