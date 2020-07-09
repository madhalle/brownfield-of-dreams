require 'rails_helper'

describe 'As Vistor'do
  it "can view the get started page" do
    visit '/get_started'
    expect(page).to have_link('Sign In')
  end
end
