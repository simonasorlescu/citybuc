require 'spec_helper'

describe MediaController do
  describe "GET index" do
    context "GET event media" do
      before do
        @event = create(:event)
        @medium = create(:medium)
        @event.media << @medium
        get :index, format: :json, event_id: @event.id
      end

      it "is successful" do
        response.should be_success
      end

      it "returns correct JSON" do
        body = JSON.parse response.body
        body.length.should == 1
        actual = body[0]
        expected = JSON.parse @medium.to_json
        actual.should eq expected
      end
    end

    context "GET location media" do
      before do
        @location = create(:location)
        @medium = create(:medium)
        @location.media << @medium
        get :index, format: :json, location_id: @location.id
      end

      it "is successful" do
        response.should be_success
      end

      it "returns correct JSON" do
        body = JSON.parse response.body
        body.length.should == 1
        actual = body[0]
        expected = JSON.parse @medium.to_json
        actual.should eq expected
      end
    end
  end

  describe "GET show" do
    before do
      @location = create(:location)
      @medium = create(:medium)
      @location.media << @medium
      get :show, format: :json, id: @medium, location_id: @location.id
    end

    it "is successful" do
      response.should be_success
    end

    it "assigns the requested medium to @medium" do
      assigns(:medium).should eq @medium
    end

    it "returns correct JSON" do
      body = JSON.parse(response.body)
      body['id'].should == @medium.id
      response.body.should == @medium.to_json
    end
  end
end
