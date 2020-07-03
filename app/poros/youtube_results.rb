class YoutubeResults
  def create_videos(tutorial)
    json = YoutubeService.new.playlist_info(tutorial.playlist_id)
    json[:items].map { |video_data| }
  end
end
