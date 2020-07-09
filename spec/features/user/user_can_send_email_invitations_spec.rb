require 'rails_helper'

RSpec.describe "when logged in as a user", :vcr do
  it "can send an invite to a github user" do
    user = create(:user, token: ENV["GITHUB_TOKEN"], github_username: "jpc20")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit(dashboard_path)

    click_link "Send an Invite"
    expect(current_path).to eq("/invite")

    fill_in :github_handle, with: 'madhalle'
    click_on "Send Invite"

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Successfully sent invite!")
  end

  it "can't send an invite to a invalid user" do
    user = create(:user, token: ENV["GITHUB_TOKEN"], github_username: "jpc20")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit(dashboard_path)

    click_link "Send an Invite"
    expect(current_path).to eq("/invite")

    fill_in :github_handle, with: ''
    click_on "Send Invite"

    expect(current_path).to eq(root_path)
    expect(page).to have_content("The Github user you selected doesn't have an email address associated with their account.")
  end
end
