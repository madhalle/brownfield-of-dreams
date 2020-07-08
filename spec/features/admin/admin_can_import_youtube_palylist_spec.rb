require 'rails_helper'

describe "An admin can import a youtube playlist", :vcr do

  before :each do
    @admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

  end
  it "from the new admin tutorial path" do
    visit new_admin_tutorial_path

    fill_in 'Title', with: "New Tutorial"
    fill_in 'Description', with: "New Tutorial Description"
    fill_in 'Thumbnail', with: "https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg"

    click_link "Import Youtube Playlist"
    fill_in 'tutorial_playlist_id', with: 'RDQMVYZqmir5xl0'
    click_on 'Save'

    expect(current_path).to eq(admin_dashboard_path)
    expect(page).to have_content('Successfully created tutorial. View it here.')

    click_link "View it here."
    tutorial = Tutorial.last
    expect(current_path).to eq(tutorial_path(tutorial.id))

    video = Video.last
    expect(video.tutorial_id).to eq(tutorial.id)
  end

  it "retains original sequence and can be longer than 50 videos" do
    visit new_admin_tutorial_path

    fill_in 'Title', with: "New Tutorial"
    fill_in 'Description', with: "New Tutorial Description"
    fill_in 'Thumbnail', with: "https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg"

    click_link "Import Youtube Playlist"
    fill_in 'tutorial_playlist_id', with: 'PLDIoUOhQQPlXr63I_vwF9GD8sAKh77dWU'
    click_on 'Save'
    click_link "View it here."
    tutorial = Tutorial.last
    expect(tutorial.videos.count).to be > 50
    expect(tutorial.videos.first.title).to eq('DaBaby – ROCKSTAR FT RODDY RICCH [Audio]')
  end

end
