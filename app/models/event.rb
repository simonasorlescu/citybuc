class Event < ActiveRecord::Base
  attr_accessible :description, :url, :location_id, :name, :date, :media, :picture

  has_many :reviews
  has_many :media, as: :mediable
  belongs_to :location
  has_and_belongs_to_many :categories

  validates_presence_of :name, :description
  validates :url, url: true

  def get_events_by_location(location_id)
    Event.where("location_id = #{location_id}").order("created_at DESC")
  end

  def self.get_events_with_locations
    Event.joins('INNER JOIN locations l ON l.id = events.location_id')
         .select("events.*, l.address")
  end

  def self.get_event_with_location(event_id)
    events = Event.joins('INNER JOIN locations l ON l.id = events.location_id')
                  .select("events.*, l.address")
                  .where("events.id = #{event_id}")
    events[0]
  end

  def self.get_events_near_location(latitude, longitude, range=1)
    kilometers = 6371
    miles = 3959
    Event.joins('INNER JOIN locations l ON l.id = events.location_id')
         .select("events.*, (#{kilometers} * acos(cos(radians(#{latitude})) * cos(radians(latitude)) * cos(radians(longitude) - radians(#{longitude})) + sin(radians(#{latitude})) * sin(radians(latitude)))) AS distance")
         .having("distance < #{range}")
         .order('distance')
         .limit(20)
         .offset(0)
  end

  def get_event_reviews
    # SELECT * FROM reviews WHERE event_id = #{  }
    self.reviews
  end

  def get_event_media
    self.media
  end

  def get_all_users_subscribed_to_event
    # SELECT u.*
     # FROM locations c, users u, subscriptions s, events e
     # WHERE l.id = #{}
     # AND s.location_id = e.location_id
     # AND s.user_id = u.id
    User.joins('INNER JOIN subscriptions s ON s.user_id = users.id')
        .joins('INNER JOIN locations l ON l.id = s.location_id')
        .joins('INNER JOIN events e ON e.location_id = l.id')
        .where("e.id = #{self.id}")
  end

  def get_new_events
    Event.where("date > ?", Time.now)
  end

  def average_rating
    self.reviews.average(:rating).to_f
  end

  def as_json(options={})
    super((options||{}).merge({
      methods: [:average_rating]
    }))
  end
end
