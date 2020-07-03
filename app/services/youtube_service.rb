class YoutubeService
  def video_info(id)
    params = { part: 'snippet,contentDetails,statistics', id: id }

    get_json('youtube/v3/videos', params)
  end

  def playlist_video_data(id)
    data = playlist_info(id)
    data[:items].map do |video|
      {
        video_id: video[:id],
        title: video[:snippet][:title],
        thumbnail: video[:snippet][:thumbnails][:high][:url],
        description: video[:snippet][:description]
      }
    end
  end

  private

  def playlist_info(id)
    params = { part: 'snippet,contentDetails', playlistId: id, maxResults: 100 }

    get_json('youtube/v3/playlistItems', params)
  end

  def get_json(url, params)
    response = conn.get(url, params)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://www.googleapis.com') do |f|
      f.adapter Faraday.default_adapter
      f.params[:key] = ENV['YOUTUBE_API_KEY']
    end
  end
end
