require 'spec_helper'

describe SubscriptionsController do
  describe "location subscriptions" do
    before do
      @user = create(:user)
      @location = create(:location)
    end

    describe "GET index" do
      before do
        @subscription = create(:subscription, user: @user, location: @location)
        get :index, format: :json, user_id: @user.id
      end

      it "is successful" do
        response.should be_success
      end

      it "assigns all subscriptions to @subscriptions" do
        assigns(:subscriptions).should eq [@subscription]
      end

      it "returns correct json" do
        response.body.should == assigns(:subscriptions).to_json
      end

      after do
        @subscription.destroy
      end
    end

    describe "GET show" do
      before do
        @subscription = create(:subscription, user: @user, location: @location)
        get :show, format: :json, id: @subscription, user_id: @user.id
      end

      it "is successful" do
        response.should be_success
      end

      it "assigns the requested subscription to @subscription" do
        assigns(:subscription).should eq @subscription
      end

      it "returns correct json" do
        body = JSON.parse(response.body)
        body["id"].should == @subscription.id
        response.body.should == @subscription.to_json
      end
    end

    describe "GET new" do
      it "assigns a new subscription to @subscription" do
        @subscription = create(:subscription, user: @user, location: @location)
        get :new, format: :json, user_id: @user.id
        assigns(:subscription).should be_a_new Subscription
      end
    end

    describe "POST create" do
      before do
        @attributes = attributes_for(:subscription, user_id: @user.id, location_id: @location.id)
      end

      it "is successful" do
        post :create, format: :json, subscription: @attributes, user_id: @user.id
        response.should be_success
      end

      it "creates a new subscription" do
        expect{
          post :create, subscription: @attributes, user_id: @user.id
        }.to change(Subscription,:count).by(1)
      end

      it "sets @subscription" do
        post :create, format: :json, subscription: @attributes, user_id: @user.id
        subscriptions = Subscription.all
        subscriptions.count.should == 1
        assigns(:subscription).should == subscriptions[0]
      end

      it "assigns a newly created subscription to @subscription" do
        post :create, format: :json, subscription: @attributes, user_id: @user.id
        assigns(:subscription).should be_a Subscription
        assigns(:subscription).should be_persisted
      end

      it "returns created subscription in json" do
        post :create, format: :json, subscription: @attributes, user_id: @user.id
        subscriptions = Subscription.all
        response.body.should == subscriptions[0].to_json
      end
    end

    describe 'DELETE destroy' do
      it "deletes the subscription" do
        subscription = create(:subscription, user: @user, location: @location)
        expect{
          delete :destroy, id: subscription, user_id: @user.id
        }.to change(Subscription,:count).by(-1)
      end
    end
  end

  describe "category subscriptions" do
    before do
      @user = create(:user)
      @category = create(:category)
    end

    describe "GET index" do
      before do
        @subscription = create(:subscription, user: @user, category: @category)
        get :index, format: :json, user_id: @user.id
      end

      it "is successful" do
        response.should be_success
      end

      it "assigns all subscriptions to @subscriptions" do
        assigns(:subscriptions).should eq [@subscription]
      end

      it "returns correct json" do
        response.body.should == assigns(:subscriptions).to_json
      end

      after do
        @subscription.destroy
      end
    end

    describe "GET show" do
      before do
        @subscription = create(:subscription, user: @user, category: @category)
        get :show, format: :json, id: @subscription, user_id: @user.id
      end

      it "is successful" do
        response.should be_success
      end

      it "assigns the requested subscription to @subscription" do
        assigns(:subscription).should eq @subscription
      end

      it "returns correct json" do
        body = JSON.parse(response.body)
        body["id"].should == @subscription.id
        response.body.should == @subscription.to_json
      end
    end

    describe "GET new" do
      it "assigns a new subscription to @subscription" do
        @subscription = create(:subscription, user: @user, category: @category)
        get :new, format: :json, user_id: @user.id
        assigns(:subscription).should be_a_new Subscription
      end
    end

    describe "POST create" do
      before do
        @attributes = attributes_for(:subscription, user_id: @user.id, category_id: @category.id)
      end

      it "is successful" do
        post :create, format: :json, subscription: @attributes, user_id: @user.id
        response.should be_success
      end

      it "creates a new subscription" do
        expect{
          post :create, subscription: @attributes, user_id: @user.id
        }.to change(Subscription,:count).by(1)
      end

      it "sets @subscription" do
        post :create, format: :json, subscription: @attributes, user_id: @user.id
        subscriptions = Subscription.all
        subscriptions.count.should == 1
        assigns(:subscription).should == subscriptions[0]
      end

      it "assigns a newly created subscription to @subscription" do
        post :create, format: :json, subscription: @attributes, user_id: @user.id
        assigns(:subscription).should be_a Subscription
        assigns(:subscription).should be_persisted
      end

      it "returns created subscription in json" do
        post :create, format: :json, subscription: @attributes, user_id: @user.id
        subscriptions = Subscription.all
        response.body.should == subscriptions[0].to_json
      end
    end

    describe 'DELETE destroy' do
      it "deletes the subscription" do
        subscription = create(:subscription, user: @user, category: @category)
        expect{
          delete :destroy, id: subscription, user_id: @user.id
        }.to change(Subscription,:count).by(-1)
      end
    end
  end

  after do
    @user.destroy
  end
end
