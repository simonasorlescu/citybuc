class Category < ActiveRecord::Base
  attr_accessible :description, :name, :parent_id

  validates :name, presence: true

  has_many :subscriptions
  has_and_belongs_to_many :locations
  has_many :subcategories, class_name: "Category", foreign_key: "parent_id"
end
