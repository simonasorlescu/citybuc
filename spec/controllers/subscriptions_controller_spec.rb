require 'spec_helper'

describe SubscriptionsController do
  before do
    @subscription = create(:subscription)
  end

  describe "GET index" do
    before do
      get :index, format: :json
    end

    it "is successful" do
      response.should be_success
    end

    it "assigns all subscriptions to @subscriptions" do
      assigns(:subscriptions).should eq([@subscription])
    end

    it "returns correct JSON" do
      body = JSON.parse(response.body)
      body.should include @subscription
      response.body.should == @subscriptions.to_json
    end
  end

  describe "GET show" do
    before do
      get :show, format: :json, id: @subscription
    end

    it "is successful" do
      response.should be_success
    end

    it "assigns the requested subscription to @subscription" do
      assigns(:subscription).should eq(@subscription)
    end

    it "returns the correct subscription when correct id is passed" do
      body = JSON.parse(response.body)
      body["id"].should == @subscription.id
    end

    it "renders the correct JSON" do
      response.body.should == @subscription.to_json
    end
  end

  describe "GET new" do
    it "assigns a new subscription to @subscription" do
      get :new, format: :json
      assigns(:subscription).should be_a_new(Subscription)
    end
  end

  describe "POST create" do
    context "with valid attributes" do
      it "is successful" do
        post :create, subscription: attributes_for(:subscription)
        response.should be_success
      end

      it "creates a new subscription" do
        expect{
          post :create, subscription: attributes_for(:subscription)
        }.to change(Subscription,:count).by(1)
      end

      it "sets @subscription" do
        post :create, subscription: attributes_for(:subscription)
        assigns(:subscription).should == @subscription
      end

      it "assigns a newly created subscription to @subscription" do
        post :create, subscription: attributes_for(:subscription)
        assigns(:subscription).should be_a(Subscription)
        assigns(:subscription).should be_persisted
      end

      it "returns created subscription in json" do
        post :create, subscription: attributes_for(:subscription)
        body = JSON.parse(response.body)
        body.should == @subscription.to_json
      end

      it "redirects to the created subscription" do
        post :create, subscription: attributes_for(:subscription)
        response.should redirect_to Subscription.last
      end
    end

    context "with invalid attributes" do
      it "does not save the new subscription" do
        expect{
          post :create, subscription: attributes_for(:invalid_subscription)
        }.to_not change(Subscription,:count)
      end

      it "re-renders the new method" do
        post :create, subscription: attributes_for(:invalid_subscription)
        response.should render_template :new
      end
    end
  end

  describe 'DELETE destroy' do
    it "deletes the subscription" do
      expect{
        delete :destroy, id: @subscription
      }.to change(Subscription,:count).by(-1)
    end

    it "redirects to subscriptions#index" do
      delete :destroy, id: @subscription
      response.should redirect_to subscriptions_url
    end
  end
end
