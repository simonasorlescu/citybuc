class Category < ActiveRecord::Base
  attr_accessible :description, :name, :parent_id

  validates :name, presence: true

  has_many :subscriptions
  has_and_belongs_to_many :locations
  has_many :subcategories, class_name: "Category", foreign_key: "parent_id"

  def get_all_users_subscribed_to_category
    User.joins('INNER JOIN subscriptions s ON s.user_id = users.id')
      .joins('INNER JOIN categories c ON c.id = s.category_id')
      .where("c.id = #{self.id}")
  end
end
