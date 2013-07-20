require 'factory_girl_rails'

namespace :db do
  desc "Populate the database with some sample data"
  task :populate, [:count] => [:environment] do |t, args|
    args.with_defaults(:count => 5)
    puts "Resetting the database"
    Rake::Task['db:reset'].invoke

    puts "Creating #{args[:count]*2} locations"
    locations = FactoryGirl.create_list(:location, args[:count]*2.to_i)
    puts "Creating an event for each location"
    events = []
    puts "Creating a medium for each location and event"
    locations.each_with_index do |l,index|
      event = FactoryGirl.create(:event, :location_id => l.id)
      events.push event
      medium = FactoryGirl.create(:medium)
      l.media << medium
      medium = FactoryGirl.create(:medium)
      events[index].media << medium
    end

    puts "Creating #{args[:count]} categories"
    categories = FactoryGirl.create_list(:category, args[:count].to_i)

    puts "Creating #{args[:count]} users"
    users = FactoryGirl.create_list(:user, args[:count].to_i)
    puts "Creating a review for each event and location"
    puts "Creating a subscription for each category and location"
    users.each_with_index do |u,index|
      FactoryGirl.create(:review, :user_id => u.id, event: events[index])
      FactoryGirl.create(:review, :user_id => u.id, location: locations[index])
      FactoryGirl.create(:subscription, :user_id => u.id, category: categories[index])
      FactoryGirl.create(:subscription, :user_id => u.id, location: locations[index+2])
    end

    puts "Done!"
  end
end