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

  # describe 'GET events by category' do
  #   it 'lets me get events by category' do
  #     cat1 = create(:category)
  #     cat2 = create(:category)
  #     event1 = create(:event)
  #     event2 = create(:event)
  #     cat1.events<<event1
  #     cat2.events<<event2
  #     cat1.events.should include event1
  #     cat2.events.should_not include event1
  #   end
  # end

  describe 'GET events near location' do
    before do
      lat = 44.432799
      lng = 26.103859
      @loc1 = FactoryGirl.create(:location, latitude: 44.432799, longitude: 26.103859)
      @loc2 = FactoryGirl.create(:location, latitude: 44.434937, longitude: 26.019809)
      @ev1 = create(:event, location: @loc1)
      @ev2 = create(:event, location: @loc2)
      get :events_near_location, format: :json, :lat => lat, :lng => lng, :range => 1
    end

    it "is successful" do
      response.should be_success
    end

    it "returns correct JSON" do
      body = JSON.parse(response.body)
      body.length.should == 1
      body[0]['id'].should == @ev1.id
    end

    after do
      events = Event.all
      for event in events
        event.destroy
      end
      locations = Location.all
       for location in locations
        location.destroy
      end
    end
  end
end
