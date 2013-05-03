require 'spec_helper'

describe Category do
  it "has a valid factory" do
    create(:category).should be_valid
  end

  it "is invalid without a name" do
    build(:category, name: nil).should_not be_valid
  end

  it 'lets me get all users subscribed to category' do
    category = create(:category)
    user = create(:user)
    sub = Subscription.create(user_id: user.id, category_id: category.id)
    users = category.get_all_users_subscribed_to_category
    users.should include user
  end
end
