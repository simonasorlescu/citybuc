require 'spec_helper'

describe MediaController do
  before do
    @medium = create(:medium)
  end

  describe "GET index" do
    before do
      get :index, format: :json
    end

    it "is successful" do
      response.should be_success
    end

    it "assigns all media to @media" do
      assigns(:media).should eq([@medium])
    end

    it "returns correct JSON" do
      body = JSON.parse(response.body)
      body.should include @medium.address
      body.should == assigns(:media).to_json
    end
  end

  describe "GET show" do
    before do
      get :show, format: :json, id: @medium
    end

    it "is successful" do
      response.should be_success
    end

    it "assigns the requested medium to @medium" do
      assigns(:medium).should eq(@medium)
    end

    it "returns the correct medium when correct id is passed" do
      body = JSON.parse(response.body)
      body["id"].should == @medium.id
    end

    it "renders the correct JSON" do
      body.should == @medium.to_json
    end
  end
end
