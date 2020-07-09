class GithubService
  def repos(token)
    repos = conn(token).get('/user/repos')
    JSON.parse(repos.body, symbolize_names: true)
  end

  def followers(token)
    followers = conn(token).get('/user/followers')
    JSON.parse(followers.body, symbolize_names: true)
  end

  def followings(token)
    followings = conn(token).get('/user/following')
    JSON.parse(followings.body, symbolize_names: true)
  end

  def get_email(username)
    user_email_info = user_conn(username).get
    JSON.parse(user_email_info.body, symbolize_names: true)
  end

  private

  def conn(token)
    Faraday.new('https://api.github.com') do |req|
      req.headers['Authorization'] = "token #{token}"
    end
  end

  def user_conn(username)
    Faraday.new("https://api.github.com/users/#{username}")
  end
end
