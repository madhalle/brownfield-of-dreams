require 'rails_helper'

RSpec.describe Video do

  describe 'relationships' do
    it {should belong_to :tutorial}
    it {should have_many(:users).through(:user_videos)}
    it {should have_many(:user_videos).dependent(:destroy)}
  end

  describe 'validations' do
    it {should validate_presence_of(:title)}
  end

  describe 'methods' do
    it "by_tutorial" do
      tutorial1= create(:tutorial, title: "How to Tie Your Shoes")
      video1 = create(:video, title: "The Bunny Ears Technique", tutorial: tutorial1)
      video2 = create(:video, title: "The Other Technique", tutorial: tutorial1)
      tutorial2= create(:tutorial, title: "Surfing")
      video3 = create(:video, title: "Big waves", tutorial: tutorial2)
      video4 = create(:video, title: "Small waves", tutorial: tutorial2)
      user = create(:user)
      UserVideo.create(user_id: user.id, video_id: video1.id)
      UserVideo.create(user_id: user.id, video_id: video2.id)
      UserVideo.create(user_id: user.id, video_id: video3.id)
      expect(user.videos.by_tutorial[tutorial1]).to eq([video1, video2])
      expect(user.videos.by_tutorial[tutorial2]).to eq([video3])
    end
  end

end
