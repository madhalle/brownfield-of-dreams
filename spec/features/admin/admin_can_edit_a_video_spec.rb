require 'rails_helper'

describe 'An admin user can edit a video' do
  it 'from the tutoral show page' do
    admin = create(:user, role: 1)
    tutorial = create(:tutorial)
    video1 = create(:video, tutorial_id: tutorial.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit tutorial_path(tutorial.id)
    click_on "Edit Video"
    expect(current_path).to eq(edit_admin_video_path(video1.id))

    fill_in "video[title]", with: 'New Video'
    fill_in "video[description]", with: 'New Description'
    fill_in "video[thumbnail]", with: 'J7ikFUlkP_k'

    click_on 'Update Video'

    expect(current_path).to eq(tutorial_path(tutorial.id))
    expect(page).to have_content('Video Updated')

    video = Video.last
    expect(video.title).to eq('New Video')
    expect(video.description).to eq('New Description')
    expect(video.thumbnail).to eq('J7ikFUlkP_k')
  end
  it 'must fill out all fields' do
    admin = create(:user, role: 1)
    tutorial = create(:tutorial)
    video1 = create(:video, tutorial_id: tutorial.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)


    visit edit_admin_video_path(video1.id)

    fill_in "video[title]", with: ''
    fill_in "video[description]", with: 'New Description'
    fill_in "video[thumbnail]", with: 'J7ikFUlkP_k'

    click_on 'Update Video'

    expect(page).to have_content("Title can't be blank")
  end

end
