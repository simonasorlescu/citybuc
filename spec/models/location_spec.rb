require 'spec_helper'

describe Location do
  it "has a valid factory" do
    create(:location).should be_valid
  end

  it "is invalid without a name" do
    build(:location, name: nil).should_not be_valid
  end

  it "is invalid without an address" do
    build(:location, address: nil).should_not be_valid
  end

  it "is invalid when url format is invalid" do
    build(:location, url: %w[location,com location example.location@foo.
                     foobar-com]).should_not be_valid
  end

  before do
    @location = Location.new(name: "Example Location", address: "location example", url: "http://www.event.com", latitude: 45.75465, longitude: -23)
  end

  subject { @location }


  describe "when address is not present" do
    before { @location.address = " " }
    it { should_not be_valid }
  end

  describe "when url format is invalid" do
    it "is invalid" do
      urls = %w[location,com location example.location@foo. foobar-com]
      urls.each do |invalid_url|
        @location.url = invalid_url
        @location.should_not be_valid
      end
    end
  end

  describe "when url format is valid" do
    it "is valid" do
      urls = %w[http://www.google.ro]
      urls.each do |valid_url|
        @location.url = valid_url
        @location.should be_valid
      end
    end
  end

  describe "when latitude format is invalid" do
    it "is invalid" do
      lat = [1076.5, -400]
      lat.each do |invalid_lat|
        @location.latitude = invalid_lat
        @location.should be_invalid
      end
    end
  end

  describe "when latitude format is valid" do
    it "is valid" do
      lat = [44.456988, 26.123815]
      lat.each do |valid_lat|
        @location.latitude = valid_lat
        @location.should be_valid
      end
    end
  end

  describe "when longitude format is invalid" do
    it "is invalid" do
      lng = [1046.5, -40.2438343]
      lng.each do |invalid_lng|
        @location.longitude = invalid_lng
        @location.should be_invalid
      end
    end
  end

  describe "when longitude format is valid" do
    it "is valid" do
      lng = [144.456988, -0.123815]
      lng.each do |valid_lng|
        @location.longitude = valid_lng
        @location.should be_valid
      end
    end
  end

  it 'get all users subscribed to location' do
    @location.save
    user = User.create(name: "Example User", email: "user@example.com",
                 password: "foobar12", password_confirmation: "foobar12")
    sub = Subscription.create(user_id: user.id,location_id:@location.id)
    users = @location.getAllUsersSubscribedToLocation
    users.should include(user)
  end

  it 'get all reviews of location' do
    @location.save
    rev1 = Review.create(title: "review1", description: "description1",location_id:@location.id)
    rev2 = Review.create(title: "review2", description: "description2",location_id:@location.id)
    reviews = @location.getLocationReviews
    reviews.should include(rev1)
    reviews.should include(rev2)
  end

  it 'get average rating for location' do
      @location.save
      rev1 = Review.create(title: "review1", description: "description1",rating:2, location_id: @location.id)
      rev2 = Review.create(title: "review2", description: "description2",rating:3, location_id: @location.id)
      avg = @location.getAvgRating
      avg.should == 2.5
    end
end
