class Medium < ActiveRecord::Base
  attr_accessible :title, :description, :url, :mediable_type, :mediable_id

  validates_presence_of :title, :url
  validates :url, url: true

  belongs_to :mediable, polymorphic: true
end
