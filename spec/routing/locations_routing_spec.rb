require "spec_helper"

describe LocationsController do
  describe "routing" do

    it "routes to #index" do
      get("/locations").should route_to("locations#index")
    end

    it "routes to #show" do
      get("/locations/1").should route_to("locations#show", :id => "1")
    end

  end
end
