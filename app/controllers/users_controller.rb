class UsersController < ApplicationController
  def show
    @repos = GithubResults.new.repos(current_user.token) if current_user.token
    @followers = GithubResults.new.followers(current_user.token) if current_user.token
    @followings = GithubResults.new.followings(current_user.token) if current_user.token
    @friends = current_user.friendships.map { |friendship| friendship.friend.github_username }
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to dashboard_path
      flash[:notice] = "Logged in as #{user.first_name}"
      flash[:notice2] = "This account has not yet been activated. Please check your email."
      generate_validation_email
    else
      flash[:error] = user.errors.full_messages.to_sentence
      @user = User.new
      render :new
    end
  end

  def update
    current_user.update!(status:"Active")
    redirect_to dashboard_path
    flash[:notice] = "Thank you! Your account is now activated"
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end

  def generate_validation_email
    recipient = current_user.email
    email_info = { account_holder: current_user.first_name }

    ValidationMailer.inform(email_info, recipient).deliver_now
  end
end
