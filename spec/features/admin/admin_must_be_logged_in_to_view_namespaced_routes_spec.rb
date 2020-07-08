require 'rails_helper'

describe 'As an Admin' do
  it "must log in to view admin dashboard" do
    expect{ visit admin_dashboard_path }.to raise_error(ActionController::RoutingError)
  end
end
