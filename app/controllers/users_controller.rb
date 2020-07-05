class UsersController < ApplicationController
  def show
    @repos = GithubResults.new.repos(current_user.token) if current_user.token
    @followers = GithubResults.new.followers(current_user.token) if current_user.token
    @followings = GithubResults.new.followings(current_user.token) if current_user.token
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = user.errors.full_messages.to_sentence
      @user = User.new
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
