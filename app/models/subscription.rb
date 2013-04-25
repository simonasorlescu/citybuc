class Subscription < ActiveRecord::Base
  attr_accessible :user_id, :category_id, :location_id, :subscribed_off

  belongs_to :user
  belongs_to :location
  belongs_to :category
end
