require 'rails_helper'

describe "Admin can create a tutorial" do

  it "from the admin new tutorial path" do
    admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    visit new_admin_tutorial_path
    fill_in 'tutorial[title]', with: 'New Tutorial'
    fill_in 'tutorial[description]', with: 'New Tutorial Description'
    fill_in 'tutorial[thumbnail]', with: 'https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg'
    click_on 'Save'
    new_tutorial = Tutorial.last
    expect(current_path).to eq(tutorial_path(new_tutorial.id))
    expect(page).to have_content("Successfully created tutorial")
  end
end
