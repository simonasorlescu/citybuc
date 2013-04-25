require "spec_helper"

describe CategoriesController do
  describe "routing" do
    it "routes to #index" do
      get("/categories").should route_to("categories#index")
    end
  end
end
