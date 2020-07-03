require 'rails_helper'

describe "An admin can import a youtube playlist" do
  it "from the new admin tutorial path" do
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    visit new_admin_tutorial_path
    # y = YoutubeService.new.playlist_info('RDQMVYZqmir5xl0')
    # require "pry"; binding.pry
    fill_in 'Title', with: "New Tutorial"
    fill_in 'Description', with: "New Tutorial Description"
    fill_in 'Thumbnail', with: "https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg"

    click_link "Import Youtube Playlist"
    fill_in 'tutorial_playlist_id', with: 'RDQMVYZqmir5xl0'
    click_on 'Save'

    expect(current_path).to eq(admin_dashboard_path)
    expect(page).to have_content('Successfully created tutorial. View it here.')

    click_link "View it here."
    expect(current_path).to eq(tutorial_path(Tutorial.last.id))
  end
end
