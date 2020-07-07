class Video < ApplicationRecord
  has_many :user_videos, dependent: :destroy
  has_many :users, through: :user_videos
  belongs_to :tutorial

  def self.by_tutorial
    joins(:tutorial).group_by{ |video| video.tutorial }
  end
end
