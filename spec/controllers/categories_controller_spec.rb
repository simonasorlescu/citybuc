require 'spec_helper'

describe CategoriesController do
  describe "GET index" do
    before do
      @category = create(:category)
      get :index, format: :json
    end

    it "is successful" do
      response.should be_success
    end

    it "assigns all categories to @categories" do
      assigns(:categories).should eq([@category])
    end

    it "returns correct JSON" do
      body = JSON.parse(response.body)
      body.should include @category
      body.should == assigns(:categories).to_json
    end
  end
end
