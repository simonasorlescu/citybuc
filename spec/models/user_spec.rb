require 'spec_helper'

describe User do
  it "has a valid factory" do
    create(:user).should be_valid
  end

  it "is invalid without a username" do
    build(:user, username: nil).should_not be_valid
  end

  it "is invalid without an email" do
    build(:user, email: nil).should_not be_valid
  end

  it "is invalid if username is too long" do
    build(:user, username: "a"*51).should_not be_valid
  end

  describe 'has subscriptions' do
    before :each do
      @user = create(:user)
      @location = create(:location)
      @category = create(:category)
      @sub1 = Subscription.create(user_id: @user.id, location_id: @location.id)
      @sub2 = Subscription.create(user_id: @user.id, category_id: @category.id)
    end

    it "lets me get his subscriptions" do
      subs = @user.get_subscriptions
      subs.should include @sub1
      subs.should include @sub2
    end

    it 'lets me get subscriptions by category' do
      cat_subs = @user.get_subscriptions_by_category
      cat_subs.should include @sub2
      cat_subs.should_not include @sub1
    end

    it 'lets me get subscriptions by location' do
      loc_subs = @user.get_subscriptions_by_location
      loc_subs.should include @sub1
      loc_subs.should_not include @sub2
    end

    it 'lets me get subscriptions by event' do
      location2 = create(:location)
      event1 = create(:event, location_id: @location.id)
      event2 = create(:event, location_id: location2.id)
      events = @user.get_events_by_subscription
      events.should include event1
      events.should_not include event2
      events.size.should == 1
    end
  end

  describe "has reviews" do
    it 'lets me get his reviews' do
      @user = create(:user)
      review = create(:review, user_id: @user.id)
      reviews = @user.get_user_reviews
      reviews.should include review
    end
  end
end

