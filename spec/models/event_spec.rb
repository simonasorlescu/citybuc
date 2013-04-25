require 'spec_helper'

describe Event do
  it "has a valid factory" do
    create(:event).should be_valid
  end

  it "is invalid without a name" do
    build(:event, name: nil).should_not be_valid
  end

  it "is invalid without a description" do
    build(:event, description: nil).should_not be_valid
  end

  it "is invalid when url format is invalid" do
    build(:event, url: %w[event,com event example.event@foo.
                     foobar-com]).should_not be_valid
  end

  it "is valid when url format is valid" do
    build(:event, url: "http://example.com").should be_valid
  end

  before do
    @event = Event.new(name: "Example Event", description: "Example Description", url:"http://www.example.com")
  end

  subject { @event }

  describe "when url format is invalid" do
    it "is invalid" do
      urls = %w[event,com event example.event@foo.
                     foobar-com]
      urls.each do |invalid_url|
        @event.url = invalid_url
        @event.should_not be_valid
      end
    end
  end

  # describe "when url format is valid" do
  #   it "is valid" do
  #     urls = %w[http://eventbar.org]
  #     urls.each do |valid_url|
  #       @event.url = valid_url
  #       @event.should be_valid
  #     end
  #   end
  # end

  describe 'when event' do
      it 'get events by location' do
      location = Location.create(name: 'location1',address:'address1',url:'http://www.example.com',latitude: '34.4534', longitude: '34.4534')
      @event.location = location
      @event.save
      events = @event.getEventsByLocation(location.id)
      events.should include(@event)
    end

    it 'get events by category' do
      location = Location.create(name: 'location1',address:'address1',url:'http://www.example.com',latitude: '34.4534', longitude: '34.4534')
      cat1 = Category.create(name:'category1')
      cat2 = Category.create(name:'category2')
      @event.location = location
      @event.save
      cat1.locations << location
      cat1.locations.build
      events1 = @event.getEventsByCategory(cat1.id)
      events2 = @event.getEventsByCategory(cat2.id)
      events1.should include(@event)
      events2.should == []
    end

    it 'get all users subscribed to event' do
      user = User.create(name: "Example User", email: "user@example.com",
                   password: "foobar12", password_confirmation: "foobar12")
      location = Location.create(name: 'location1',address:'address1',url:'http://www.example.com',latitude: '34.4534', longitude: '34.4534')
      sub = Subscription.create(user_id: user.id,location_id:location.id)
      @event.location = location
      @event.save
      users = @event.getAllUsersSubscribedToEvent
      users.should include(user)
    end

    it "get event reviews" do
      @event.save
      review = Review.create(title:'review1',description:'description1',event_id:@event.id)
      reviews = @event.getEventReviews
      reviews.should include(review)
    end

    it "get event media" do
      @event.save
      img1 = Medium.create(title:'media1',url:'http://www.url1.com')
      img2 = Medium.create(title:'media2',url:'http://www.url2.com')
      img1.mediable = @event
      img1.save
      medias = @event.getEventMedia
      medias.should include(img1)
      medias.should_not include(img2)
    end

    it 'get average rating for event' do
      @event.save
      rev1 = Review.create(title: "review1", description: "description1",rating:2, event_id: @event.id)
      rev2 = Review.create(title: "review2", description: "description2",rating:3, event_id: @event.id)
      avg = @event.getAvgRating
      avg.should == 2.5
    end

    it 'get new events' do
      @event.save
      event1 = Event.create(name: "event1", description: "description1", url:"http://www.example.com",date:'2013-05-22')
      event2 = Event.create(name: "event2", description: "description2", url:"http://www.example.com",date:'2013-03-22')
      new_events = @event.getNewEvents
      new_events.should include(event1)
      new_events.should_not include(event2)
    end
  end
end
