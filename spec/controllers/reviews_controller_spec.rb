require 'spec_helper'

describe ReviewsController do
  before do
    @user = create(:user)
  end

  describe "GET index" do
    context "GET event reviews" do
      before do
        @event = create(:event)
        @review = create(:review, event: @event, user: @user)
        get :index, format: :json, event_id: @event.id
      end

      it "is successful" do
        response.should be_success
      end

      it "returns correct JSON" do
        body = JSON.parse response.body
        body.length.should == 1
        actual = body[0]
        expected = JSON.parse @review.to_json
        actual.should eq expected
      end
    end

    context "GET location reviews" do
      before do
        @location = create(:location)
        @review = create(:review, location: @location, user: @user)
        get :index, format: :json, location_id: @location.id
      end

      it "is successful" do
        response.should be_success
      end

      it "returns correct JSON" do
        body = JSON.parse response.body
        body.length.should == 1
        actual = body[0]
        expected = JSON.parse @review.to_json
        actual.should eq expected
      end
    end

    context "GET user reviews" do
      before do
        @event = create(:event)
        @review = create(:review, user: @user, event: @event)
        get :index, format: :json, user_id: @user.id
      end

      it "is successful" do
        response.should be_success
      end

      it "returns correct JSON" do
        body = JSON.parse response.body
        body.length.should == 1
        actual = body[0]
        expected = JSON.parse @review.to_json
        actual.should eq expected
      end
    end
  end

  describe "GET show" do
    before do
      @event = create(:event)
      @review = create(:review, user: @user, event: @event)
      get :show, format: :json, id: @review, user_id: @user.id
    end

    it "is successful" do
      response.should be_success
    end

    it "assigns the requested review to @review" do
      assigns(:review).should eq @review
    end

    it "returns correct JSON" do
      body = JSON.parse(response.body)
      body["title"].should == @review.title
      response.body.should == @review.to_json
    end
  end

  describe "GET new" do
    it "assigns a new review to @review" do
      @event = create(:event)
      @review = create(:review, user: @user, event: @event)
      get :new, format: :json, user_id: @user.id
      assigns(:review).should be_a_new Review
    end
  end

  describe "GET edit" do
    it "assigns the requested review to @review" do
      @event = create(:event)
      @review = create(:review, user: @user, event: @event)
      get :edit, format: :json, id: @review, user_id: @user.id
      assigns(:review).should eq @review
    end
  end

  describe "POST create" do
    context "with valid attributes" do
      before do
        @event = create(:event)
        @attributes = attributes_for(:review, user_id: @user.id, event_id: @event.id)
      end

      it "is successful" do
        post :create, format: :json, review: @attributes, user_id: @user.id
        response.should be_success
      end

      it "creates a new review" do
        expect{
          post :create, format: :json, review: @attributes, user_id: @user.id
        }.to change(Review,:count).by(1)
      end

      it "sets @review" do
        post :create, format: :json, review: @attributes, user_id: @user.id
        reviews = Review.all
        reviews.count.should == 1
        assigns(:review).should == reviews[0]
      end

      it "assigns a newly created review to @review" do
        post :create, format: :json, review: @attributes, user_id: @user.id
        assigns(:review).should be_a Review
        assigns(:review).should be_persisted
      end

      it "returns created review in json" do
        post :create, format: :json, review: @attributes, user_id: @user.id
        reviews = Review.all
        response.body.should == reviews[0].to_json
      end

      after do
        reviews = Review.all
        for review in reviews
          review.destroy
        end
      end
    end

    context "with invalid attributes" do
      it "does not save the new review" do
        @event = create(:event)
        expect{
          post :create, review: attributes_for(:invalid_review, user_id: @user.id, event_id: @event.id), user_id: @user.id
        }.to_not change(Review,:count)
      end
    end
  end

  describe 'PUT update' do
    before do
      @event = create(:event)
      @review = create(:review, user: @user, event: @event, title: "Bad")
    end

    context "with valid attributes" do
      it "locates the requested @review" do
        put :update, format: :json, id: @review, review: attributes_for(:review, user_id: @user.id, event_id: @event.id), user_id: @user.id
        assigns(:review).should eq @review
      end

      it "changes @review's attributes" do
        put :update, format: :json, id: @review, review: attributes_for(:review, user_id: @user.id, event_id: @event.id, title: "Excellent"), user_id: @user.id
        @review.reload
        @review.title.should eq "Excellent"
        response.body.should == " "
      end
    end

    context "with invalid attributes" do
      it "locates the requested @review" do
        put :update, format: :json, id: @review, review: attributes_for(:invalid_review, user_id: @user.id, event_id: @event.id), user_id: @user.id
        assigns(:review).should eq @review
      end

      it "does not change @review's attributes" do
        put :update, format: :json, id: @review, review: attributes_for(:invalid_review, user_id: @user.id, event_id: @event.id), user_id: @user.id
        @review.reload
        @review.title.should eq "Bad"
        # response.should include @review.errors
      end
    end

    after do
      @review.destroy
    end
  end

  describe 'DELETE destroy' do
    it "deletes the review" do
      @review = create(:review, user: @user, event: @event)
      expect{
        delete :destroy, format: :json, id: @review, user_id: @user.id
      }.to change(Review,:count).by(-1)
      response.body.should == " "
    end
  end

  after do
    @user.destroy
  end
end
