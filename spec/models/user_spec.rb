require 'spec_helper'

describe User do
  it "has a valid factory" do
    create(:user).should be_valid
  end

  it "is invalid without a name" do
    build(:user, name: nil).should_not be_valid
  end

  it "is invalid without an email" do
    build(:user, email: nil).should_not be_valid
  end

  it "is invalid if name is too long" do
    build(:user, name: "a"*51).should_not be_valid
  end

  it "is valid with an admin user" do
    build(:user, is_admin: true).should be_valid
  end



  # before do
 #    @user = User.new(name: "Example User", email: "user@example.com",
 #                   password: "foobar12", password_confirmation: "foobar12")
 #  end

  subject { @user }

  # it { should_not be_is_admin }

  describe 'when user has subscriptions' do
    it "has subscriptions" do
      @user.save
      location = Location.create(name: 'location1',address:'address1',url:'http://www.example.com',latitude: '34.4534', longitude: '34.4534')
      category = Category.create(name:'category1')
      sub1 = Subscription.create(user_id: @user.id,location_id:location.id)
      sub2 = Subscription.create(user_id: @user.id,category_id:category.id)
      subs = @user.getSubscriptions
      subs.should include(sub1)
      subs.should include(sub2)
    end
  end

  describe 'when user has subscriptions under category' do
    it 'has subscriptions by category' do
      @user.save
      location = Location.create(name: 'location1',address:'address1',url:'http://www.example.com',latitude: '34.4534', longitude: '34.4534')
      category = Category.create(name:'category1')
      sub1 = Subscription.create(user_id: @user.id,location_id:location.id)
      sub2 = Subscription.create(user_id: @user.id,category_id:category.id)
      cat_subs = @user.getSubscriptionsByCategory
      cat_subs.should include(sub2)
      cat_subs.should_not include(sub1)
    end
  end

  describe 'when user has subscriptions under location' do
    it 'has subscriptions by location' do
      @user.save
      location = Location.create(name: 'location1',address:'address1',url:'http://www.example.com',latitude: '34.4534', longitude: '34.4534')
      category = Category.create(name:'category1')
      sub1 = Subscription.create(user_id: @user.id,location_id:location.id)
      sub2 = Subscription.create(user_id: @user.id,category_id:category.id)
      loc_subs = @user.getSubscriptionsByLocation
      loc_subs.should include(sub1)
      loc_subs.should_not include(sub2)
    end
  end

  describe 'when user has subscriptions' do
    it 'has subscriptions by event' do
      @user.save
      location1 = Location.create(name: 'location1',address:'address1',url:'http://www.example.com',latitude: '34.4534', longitude: '34.4534')
      location2 = Location.create(name: 'location2',address:'address2',url:'http://www.example.com',latitude: '34.4534', longitude: '34.4534')
      sub1 = Subscription.create(user_id: @user.id,location_id:location1.id)
      event1 = Event.create(name:'event1',description:'description1',url:'http://www.url1.com',location_id:location1.id)
      event2 = Event.create(name:'event2',description:'description2',url:'http://www.url2.com',location_id:location2.id)
      events = @user.getEventsBySubscription
      events.should include(event1)
      events.should_not include(event2)
      events.size.should == 1
    end
  end

  describe "when user has reviews" do
    it 'get user reviews' do
      @user.save
      review = Review.create(title:'review1',description:'description1',user_id:@user.id)
      reviews = @user.getUserReviews
      reviews.should include(review)
    end
  end
end

