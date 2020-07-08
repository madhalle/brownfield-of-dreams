class YoutubeService
  def video_info(id)
    params = { part: 'snippet,contentDetails,statistics', id: id }

    get_json('youtube/v3/videos', params)
  end

  def playlist_video_data(id)
    data = playlist_info(id)
    video_data = collect_video_data(data[:items])
    while data[:nextPageToken]
      data = playlist_info(id, data[:nextPageToken])
      video_data += collect_video_data(data[:items])
    end
    video_data
  end

  private

  def collect_video_data(video_data)
    video_data.map do |video|
      {
        video_id: video[:id],
        title: video[:snippet][:title],
        thumbnail: video[:snippet][:thumbnails][:high][:url],
        description: video[:snippet][:description],
        position: video[:snippet][:position]
      }
    end
  end

  def playlist_info(id, next_page_token = nil)
    params = { part: 'snippet,contentDetails', playlistId: id, maxResults: 100, pageToken: next_page_token }

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
