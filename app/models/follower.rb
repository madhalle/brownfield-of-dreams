class Follower
  attr_reader :login, :link
  def initialize(follower_data)
    @login = follower_data[:login]
    @link = follower_data[:html_url]
  end

  def account?
    User.where('github_username = ?', login).exists?
  end

  def user_id
    User.where('github_username = ?', login).pluck(:id).first
  end
end
