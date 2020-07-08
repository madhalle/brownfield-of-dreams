require 'rails_helper'

describe 'On the welcome page' do
  it "classroom content is not visible until a user is logged in" do
    user = create(:user)
    tutorial1 = create(:tutorial)
    tutorial2 = create(:tutorial, classroom: true)
    visit root_path
    expect(page).to have_content(tutorial1.title)
    expect(page).to_not have_content(tutorial2.title)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit root_path
    expect(page).to have_content(tutorial1.title)
    expect(page).to have_content(tutorial2.title)
  end
end
