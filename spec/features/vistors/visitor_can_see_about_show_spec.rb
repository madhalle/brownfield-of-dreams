require 'rails_helper'

describe 'As Vistor'do
  it "can view the about show page" do
    visit '/about'
    expect(page).to have_content('his application is designed to pull in youtube information ')
  end
end
