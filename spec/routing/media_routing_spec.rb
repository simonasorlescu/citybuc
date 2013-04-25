require "spec_helper"

describe MediaController do
  describe "routing" do

    it "routes to #index" do
      get("/media").should route_to("media#index")
    end

    it "routes to #show" do
      get("/media/1").should route_to("media#show", :id => "1")
    end

  end
end
