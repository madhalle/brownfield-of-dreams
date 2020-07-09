require 'rails_helper'

RSpec.describe Tutorial, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:title)}
    it {should validate_presence_of(:description)}
    it {should validate_presence_of(:thumbnail)}
  end

  describe 'relationships' do
    it { should have_many(:videos).dependent(:destroy) }
  end

  describe 'methods' do
    it "hide_classroom_content" do
      tutorial1 = create(:tutorial)
      tutorial2 = create(:tutorial, classroom: true)
      expect(Tutorial.hide_classroom_content).to eq([tutorial1])
    end
  end
end
