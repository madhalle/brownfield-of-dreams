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
    require "pry"; binding.pry
    redirect_to dashboard_path
    flash[:notice] = "Thank you! Your account is now activated"
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end

  def generate_validation_email
    # @email = EmailGenerator.new
    # require "pry"; binding.pry
    recipient = current_user.email
    email_info = { message: "Visit here to activate your account.",
                    account_holder: current_user.first_name}

    ValidationMailer.inform(email_info, recipient).deliver_now
    # flash[:notice2] = "This account has not yet been activated. Please check your email."
  end
end
