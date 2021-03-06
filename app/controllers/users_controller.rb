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
    @user = User.create(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Logged in as #{@user.first_name}\nAccount has not yet been activated. Please check your email."
      generate_validation_email
      redirect_to dashboard_path
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end

  def generate_validation_email
    recipient = current_user.email
    email_info = { account_holder: current_user }

    ValidationMailer.inform(email_info, recipient).deliver_now
  end
end
