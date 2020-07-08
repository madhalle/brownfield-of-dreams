require 'rails_helper'

describe "Admin can create a tutorial" do
  before :each do
    @admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
  end
  it "from the admin new tutorial path" do
    visit new_admin_tutorial_path
    fill_in 'tutorial[title]', with: 'New Tutorial'
    fill_in 'tutorial[description]', with: 'New Tutorial Description'
    fill_in 'tutorial[thumbnail]', with: 'https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg'
    click_on 'Save'
    expect(current_path).to eq(admin_dashboard_path)
    expect(page).to have_content("Successfully created tutorial")
  end

  it "Must fill out required fields" do
    visit new_admin_tutorial_path
    fill_in 'tutorial[title]', with: ''
    fill_in 'tutorial[description]', with: 'New Tutorial Description'
    fill_in 'tutorial[thumbnail]', with: 'https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg'
    click_on 'Save'
    expect(page).to have_content("Title can't be blank")
  end
end
