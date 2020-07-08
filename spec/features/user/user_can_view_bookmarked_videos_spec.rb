require 'rails_helper'

describe 'A registered user' do
  it 'can view a bookmark section with videos organized by tutorial' do
    tutorial1= create(:tutorial, title: "How to Tie Your Shoes")
    video1 = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial1, position: 1)
    video2 = create(:video, title: "The Other Technique", tutorial: tutorial1)
    tutorial2= create(:tutorial, title: "Surfing")
    video3 = create(:video, title: "Big waves", tutorial: tutorial2)
    video4 = create(:video, title: "Small waves", tutorial: tutorial2)
    user = create(:user)
    UserVideo.create(user_id: user.id, video_id: video1.id)
    UserVideo.create(user_id: user.id, video_id: video2.id)
    UserVideo.create(user_id: user.id, video_id: video3.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit dashboard_path
    within '.bookmarks' do
      within "#tutorial-#{tutorial1.id}" do
        expect(video2.title).to appear_before(video1.title)
      end
      within "#tutorial-#{tutorial2.id}" do
        expect(page).to have_content(video3.title)
        expect(page).to_not have_content(video4.title)
      end
    end
  end

end
