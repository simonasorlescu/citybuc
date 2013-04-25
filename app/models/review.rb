class Review < ActiveRecord::Base
  attr_accessible :description, :user_id, :event_id, :location_id, :rating, :title

  validates_presence_of :title, :description
  validates :rating, :numericality => { only_integer: true }, inclusion: 0..5, allow_nil: true

  belongs_to :user
  belongs_to :event
  belongs_to :location

end
