class GithubResults
  def repos(token)
    json = GithubService.new.repos(token)
    json.map { |repo_data| Repo.new(repo_data) }
  end

  def followers(token)
    json = GithubService.new.followers(token)
    json.map { |follower_data| Follower.new(follower_data) }
  end

  def followings(token)
    json = GithubService.new.followings(token)
    json.map { |following_data| Following.new(following_data) }
  end

  def user_email(username)
    json = GithubService.new.get_email(username)
    { :email => json[:email],
      :name => json[:name]
    }
  end
end
