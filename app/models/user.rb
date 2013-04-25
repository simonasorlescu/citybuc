class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me

  has_many :subscriptions, dependent: :destroy
  has_many :locations, through: :subscriptions
  has_many :categories, through: :subscriptions
  has_many :reviews

  validates :name, presence: true, length: { maximum: 50 }

  def getSubscriptions
    # SELECT * FROM subscriptions WHERE user_id = 'whatever'
    self.subscriptions
  end

  def getSubscriptionsByCategory
     # Fetches all category subscriptions for the current user.
     # The user can be subscribed to both categories and locations
     # and receives notifications of events coming from both of them.

     # SELECT s.*
     # FROM categories c, users u, subscriptions s
     # WHERE u.id = #{}
     # AND s.user_id = u.id
     # AND s.category_id IS NOT NULL
    self.subscriptions.where("category_id IS NOT NULL").order("created_at DESC")
  end

  def getSubscriptionsByLocation
     # SELECT l.*
     # FROM locations l, users u, subscriptions s
     # WHERE u.id = #{}
     # AND s.user_id = u.id
     # AND s.location_id IS NOT NULL
    self.subscriptions.where("location_id IS NOT NULL").order("created_at DESC")
  end

  def getEventsBySubscription
    # This function returns events.
    # Users are subscribed directly to locations.
    # This method returns the events produced by the locations to which the
    # user has subscribed to.

    # SELECT e.*
     # FROM events e
     # INNER JOIN locations l WHERE l.id = e.location_id
     # INNER JOIN subscriptions s WHERE s.location_id = l.id
     # WHERE u.id = #{}
    Event.joins('INNER JOIN locations l ON l.id = events.location_id')
      .joins('INNER JOIN subscriptions s ON s.location_id = l.id')
      .where("s.user_id = #{self.id}")
  end

  def getUserReviews
    self.reviews
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(name:auth.extra.raw_info.name,
                           provider:auth.provider,
                           uid:auth.uid,
                           email:auth.info.email,
                           password:Devise.friendly_token[0,20]
                           )
    end
    user
  end
end
