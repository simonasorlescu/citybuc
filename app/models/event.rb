class Event < ActiveRecord::Base
  attr_accessible :description, :url, :location_id, :name, :date, :media

  has_many :reviews
  has_many :media, as: :mediable
  belongs_to :location

  validates_presence_of :name, :description
  validates :url, url: true

  def getEventsByCategory(category_id)
    # This method returns all events that belong to a certain category.
    # @param {Integer} category_id - the id of the category where the returned events belong to.
    Event.joins('INNER JOIN locations l ON l.id = events.location_id')
      .joins('INNER JOIN categories_locations lc ON lc.location_id = l.id')
      .joins('INNER JOIN categories c ON c.id = lc.category_id')
      .where("c.id = #{category_id}")
  end

  def getEventsByLocation(location_id)
    Event.where("location_id = #{location_id}").order("created_at DESC")
  end

  def getEventReviews
    # SELECT * FROM reviews WHERE event_id = #{  }
    self.reviews
  end

  def getEventMedia
    self.media
  end

  def getAllUsersSubscribedToEvent
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

  def getNewEvents
    Event.where("date > ?", Time.now)
  end

  def getAvgRating
    self.reviews.average(:rating)
  end
end