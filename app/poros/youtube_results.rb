class YoutubeResults
  def create_videos(tutorial)
    json = YoutubeService.new.playlist_video_data(tutorial.playlist_id)
    json.each { |video_data| tutorial.videos.create(video_data) }
  end
end
