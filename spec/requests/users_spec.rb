require 'spec_helper'

# describe "Users" do
#   describe "Manage users" do
#     it "Adds a new user and displays the results" do
#       visit users_url
#       expect{
#         click_link 'New User'
#         fill_in 'Firstname', with: "John"
#         fill_in 'Lastname', with: "Smith"
#         fill_in 'home', with: "555-1234"
#         fill_in 'office', with: "555-3324"
#         fill_in 'mobile', with: "555-7888"
#         click_button "Create User"
#       }.to change(User,:count).by(1)
#       page.should have_content "User was successfully created."
#       within 'h1' do
#         page.should have_content "John Smith"
#       end
#       page.should have_content "home 555-1234"
#       page.should have_content "office 555-3324"
#       page.should have_content "mobile 555-7888"
#     end

#     it "Deletes a user", js: true do
#       DatabaseCleaner.clean
#       user = create(:user, firstname: "Aaron", lastname: "Sumner")
#       visit users_path
#       expect{
#         within "#user_#{user.id}" do
#           click_link 'Destroy'
#         end
#         alert = page.driver.browser.switch_to.alert
#         alert.accept
#       }.to change(User,:count).by(-1)
#       page.should have_content "Listing users"
#       page.should_not have_content "Aaron Sumner"
#     end
#   end
# end