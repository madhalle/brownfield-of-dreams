class YoutubeService
  def video_info(id)
    params = { part: 'snippet,contentDetails,statistics', id: id }

    get_json('youtube/v3/videos', params)
  end

  def playlist_video_data(id)
    data = playlist_info(id)
    video_data = data[:items].map do |video|
      {
        video_id: video[:id],
        title: video[:snippet][:title],
        thumbnail: video[:snippet][:thumbnails][:high][:url],
        description: video[:snippet][:description]
      }
    end
    while data[:nextPageToken]
      data = playlist_info(id, data[:nextPageToken])
      video_data +=  data[:items].map do |video|
        {
          video_id: video[:id],
          title: video[:snippet][:title],
          thumbnail: video[:snippet][:thumbnails][:high][:url],
          description: video[:snippet][:description]
        }
      end
    end
    video_data
  end

  private

  def playlist_info(id, nextPageToken=nil)
    params = { part: 'snippet,contentDetails', playlistId: id, maxResults: 100, pageToken: nextPageToken }

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
