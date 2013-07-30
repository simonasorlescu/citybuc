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
    build(:event, url: "foobar-com").should_not be_valid
  end

  it "is valid when url format is valid" do
    build(:event, url: "http://example.com").should be_valid
  end

  describe "with a location" do
    before do
      @location = create(:location)
      @event = create(:event, location: @location)
    end

    it 'lets me get events by location' do
      events = @event.get_events_by_location(@location.id)
      events.should include @event
    end

    it 'lets me get events by category' do
      cat1 = create(:category)
      cat2 = create(:category)
      cat1.locations << @location
      cat1.locations.build
      events1 = @event.get_events_by_category(cat1.id)
      events2 = @event.get_events_by_category(cat2.id)
      events1.should include @event
      events2.should == []
    end

    it 'lets me get all users subscribed to event' do
      user = create(:user)
      sub = Subscription.create(user_id: user.id, location_id: @location.id)
      users = @event.get_all_users_subscribed_to_event
      users.should include user
    end

    it 'lets me get events with locations' do
      events = Event.get_events_with_locations
      p events
      # foreach event in events:
      #    assert.equals event.address, @location.addredd
    end
  end

  describe "has methods" do
    before { @event = create(:event) }

    it "lets me get event reviews" do
      review = create(:review, event_id: @event.id)
      reviews = @event.get_event_reviews
      reviews.should include review
    end

    it "lets me get event media" do
      img1 = create(:medium)
      img2 = create(:medium)
      img1.mediable = @event
      img1.save
      media = @event.get_event_media
      media.should include img1
      media.should_not include img2
    end

    it 'lets me get average rating for event' do
      rev1 = create(:review, rating:2, event_id: @event.id)
      rev2 = create(:review, rating:3, event_id: @event.id)
      avg = @event.average_rating
      avg.should == 2.5
    end

    it 'lets me get new events' do
      event1 = create(:event ,date:'2015-05-22')
      event2 = create(:event ,date:'2013-03-22')
      new_events = @event.get_new_events
      new_events.should include event1
      new_events.should_not include event2
    end
  end

  # describe "when url format is invalid" do
  #   it "is invalid" do
  #     urls = %w[event,com event example.event@foo.
  #                    foobar-com]
  #     urls.each do |invalid_url|
  #       @event.url = invalid_url
  #       @event.should_not be_valid
  #     end
  #   end
  # end

  # describe "when url format is valid" do
  #   it "is valid" do
  #     urls = %w[http://eventbar.org]
  #     urls.each do |valid_url|
  #       @event.url = valid_url
  #       @event.should be_valid
  #     end
  #   end
  # end

  # describe 'when event' do
  #     it 'get events by location' do
  #     location = Location.create(name: 'location1',address:'address1',url:'http://www.example.com',latitude: '34.4534', longitude: '34.4534')
  #     @event.location = location
  #     @event.save
  #     events = @event.getEventsByLocation(location.id)
  #     events.should include(@event)
  #   end

  #   it 'get events by category' do
  #     location = Location.create(name: 'location1',address:'address1',url:'http://www.example.com',latitude: '34.4534', longitude: '34.4534')
  #     cat1 = Category.create(name:'category1')
  #     cat2 = Category.create(name:'category2')
  #     @event.location = location
  #     @event.save
  #     cat1.locations << location
  #     cat1.locations.build
  #     events1 = @event.getEventsByCategory(cat1.id)
  #     events2 = @event.getEventsByCategory(cat2.id)
  #     events1.should include(@event)
  #     events2.should == []
  #   end

  #   it 'get all users subscribed to event' do
  #     user = User.create(name: "Example User", email: "user@example.com",
  #                  password: "foobar12", password_confirmation: "foobar12")
  #     location = Location.create(name: 'location1',address:'address1',url:'http://www.example.com',latitude: '34.4534', longitude: '34.4534')
  #     sub = Subscription.create(user_id: user.id,location_id:location.id)
  #     @event.location = location
  #     @event.save
  #     users = @event.getAllUsersSubscribedToEvent
  #     users.should include(user)
  #   end

  #   it "get event reviews" do
  #     @event.save
  #     review = Review.create(title:'review1',description:'description1',event_id:@event.id)
  #     reviews = @event.getEventReviews
  #     reviews.should include(review)
  #   end

  #   it "get event media" do
  #     @event.save
  #     img1 = Medium.create(title:'media1',url:'http://www.url1.com')
  #     img2 = Medium.create(title:'media2',url:'http://www.url2.com')
  #     img1.mediable = @event
  #     img1.save
  #     medias = @event.getEventMedia
  #     medias.should include(img1)
  #     medias.should_not include(img2)
  #   end

  #   it 'get average rating for event' do
  #     @event.save
  #     rev1 = Review.create(title: "review1", description: "description1",rating:2, event_id: @event.id)
  #     rev2 = Review.create(title: "review2", description: "description2",rating:3, event_id: @event.id)
  #     avg = @event.getAvgRating
  #     avg.should == 2.5
  #   end

  #   it 'get new events' do
  #     @event.save
  #     event1 = Event.create(name: "event1", description: "description1", url:"http://www.example.com",date:'2013-05-22')
  #     event2 = Event.create(name: "event2", description: "description2", url:"http://www.example.com",date:'2013-03-22')
  #     new_events = @event.getNewEvents
  #     new_events.should include(event1)
  #     new_events.should_not include(event2)
  #   end
  # end
end
