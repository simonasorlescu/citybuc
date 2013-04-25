class Location < ActiveRecord::Base
  LATITUDE = /^(-?[1-8]?\d(?:\.\d{1,6})?|90(?:\.0{1,6})?)$/
  LONGITUDE = /^(-?(?:1[0-7]|[1-9])?\d(?:\.\d{1,6})?|180(?:\.0{1,6})?)$/

  attr_accessible :address, :description, :latitude, :longitude, :name, :url

  has_many :subscriptions
  has_many :users, through: :subscriptions
  has_many :events
  has_many :reviews
  has_many :media, as: :mediable
  has_and_belongs_to_many :categories

  validates_presence_of :name, :address
  validates :url, url: true
  validates :latitude, format: {with: LATITUDE}
  validates :longitude, format: {with: LONGITUDE}

  def getAllUsersSubscribedToLocation
    # SELECT u.*
     # FROM locations c, users u, subscriptions s
     # WHERE l.id = #{}
     # AND s.location_id = l.id
     # AND s.user_id = u.id
    User.joins('INNER JOIN subscriptions s ON s.user_id = users.id')
      .joins('INNER JOIN locations l ON l.id = s.location_id')
      .where("l.id = #{self.id}")
  end

  def getLocationReviews
    # SELECT * FROM reviews WHERE user_id = #{  }
    self.reviews
  end

  def getAvgRating
    self.reviews.average(:rating)
  end
end
