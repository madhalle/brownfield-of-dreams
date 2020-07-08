class Video < ApplicationRecord
  has_many :user_videos, dependent: :destroy
  has_many :users, through: :user_videos
  belongs_to :tutorial
  validates :title, presence: true

  def self.by_tutorial
    order(:position).group_by(&:tutorial)
  end
end
