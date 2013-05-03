require 'spec_helper'

describe ReviewsController do
  before do
    @review = create(:review)
  end

  describe "GET index" do
    before do
      get :index, format: :json
    end

    it "is successful" do
      response.should be_success
    end

    it "assigns all reviews to @reviews" do
      assigns(:reviews).should eq([@review])
    end

    it "returns correct JSON" do
      body = JSON.parse(response.body)
      body.should include @review.address
      body.should == assigns(:reviews).to_json
    end
  end

  describe "GET show" do
    before do
      get :show, format: :json, id: @review
    end

    it "is successful" do
      response.should be_success
    end

    it "assigns the requested review to @review" do
      assigns(:review).should eq(@review)
    end

    it "returns the correct review when correct id is passed" do
      body = JSON.parse(response.body)
      body["id"].should == @review.id
    end

    it "renders the correct JSON" do
      body.should == @review.to_json
    end
  end

  describe "GET new" do
    it "assigns a new review to @review" do
      get :new, format: :json
      assigns(:review).should be_a_new(Review)
    end
  end

  describe "GET edit" do
    it "assigns the requested review to @review" do
      get :edit, id: @review
      assigns(:review).should eq(@review)
    end
  end

  describe "POST create" do
    context "with valid attributes" do
      it "is successful" do
        post :create, review: attributes_for(:review)
        response.should be_success
      end

      it "creates a new review" do
        expect{
          post :create, review: attributes_for(:review)
        }.to change(Review,:count).by(1)
      end

      it "sets @review" do
        post :create, review: attributes_for(:review)
        assigns(:review).title.should == @review[:title]
      end

      it "assigns a newly created review to @review" do
        post :create, review: attributes_for(:review)
        assigns(:review).should be_a(Review)
        assigns(:review).should be_persisted
      end

      it "returns created review in json" do
        post :create, review: attributes_for(:review)
        body = JSON.parse(response.body)
        body["title"].should == @review[:title].to_json
      end

      it "redirects to the created review" do
        post :create, review: attributes_for(:review)
        response.should redirect_to Review.last
      end
    end

    context "with invalid attributes" do
      it "does not save the new review" do
        expect{
          post :create, review: attributes_for(:invalid_review)
        }.to_not change(Review,:count)
      end

      it "re-renders the new method" do
        post :create, review: attributes_for(:invalid_review)
        response.should render_template :new
      end
    end
  end

  describe 'PUT update' do
    before :each do
      @review = create(:review, title: "Bad")
    end

    context "valid attributes" do
      it "locates the requested @review" do
        put :update, id: @review, review: attributes_for(:review)
        assigns(:review).should eq(@review)
      end

      it "changes @review's attributes" do
        put :update, id: @review, review: attributes_for(:review, title: "Excellent")
        @review.reload
        @review.title.should eq("Excellent")
      end

      it "redirects to the updated review" do
        put :update, id: @review, review: attributes_for(:review)
        response.should redirect_to @review
      end
    end

    context "invalid attributes" do
      it "locates the requested @review" do
        put :update, id: @review, review: attributes_for(:invalid_review)
        assigns(:review).should eq(@review)
      end

      it "does not change @review's attributes" do
        put :update, id: @review, review: attributes_for(:review, title: nil)
        @review.reload
        @review.title.should_not eq("Excellent")
        @review.title.should eq("Bad")
      end

      it "re-renders the edit method" do
        put :update, id: @review, review: attributes_for(:invalid_review)
        response.should render_template :edit
      end
    end
  end

  describe 'DELETE destroy' do
    it "deletes the review" do
      expect{
        delete :destroy, id: @review
      }.to change(Review,:count).by(-1)
    end

    it "redirects to reviews#index" do
      delete :destroy, id: @review
      response.should redirect_to reviews_url
    end
  end
end
