require 'rails_helper'

RSpec.describe "when visiting the site as a user", :vcr do
  before :each do
    @user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  it "can connect to github" do
    visit "/dashboard"
    click_link "Connect to Github"

    expect(current_path).to eq dashboard_path
    expect(page).to have_css('.github')
    expect(page).to_not have_link('Connect to Github')
  end
end
