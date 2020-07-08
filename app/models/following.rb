class Following
  attr_reader :login, :link
  def initialize(following_data)
    @login = following_data[:login]
    @link = following_data[:html_url]
  end

  def account?
    User.where('github_username = ?', login).exists?
  end

  def user_id
    User.where('github_username = ?', login).pluck(:id).first
  end
end
