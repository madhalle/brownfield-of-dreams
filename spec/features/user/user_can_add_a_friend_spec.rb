# Background: A user (Josh) exists in the system with a Github token.
# The user has two followers on Github. One follower (Dione) also has an account
# within our database. The other follower (Mike) does not have an account in our system.
# If a follower or following has an account in our system we want to include a link next
# to their name to allow us to add as a friend.
#
# In this case Dione would have an Add as Friend link next to her name. Mike would not have the link next to his name.
require 'rails_helper'

RSpec.describe "When visiting the user dashboard" do
  before :each do
    @user1 = create(:user, token: ENV['GITHUB_TOKEN'], github_username: 'jpc20')
    @user2 = create(:user, token: ENV['GITHUB_TOKEN_2'], github_username: 'madhalle')
  end

  it "users have Github usernames" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit "/dashboard"
    click_link "Connect to Github"

    expect(current_path).to eq dashboard_path
    expect(page).to have_css('.github')
    expect(page).to_not have_link('Connect to Github')
    expect(user.github_username).to eq('jpc20')
  end

  it "Users see a link to add friend next to followers with an account" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
    visit "/dashboard"
    within "#follower-#{@user2.github_username}" do
      click_link "Add Friend"
    end
  end
end
