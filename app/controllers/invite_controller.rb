class InviteController < ApplicationController
  def new; end

  def create
    results = GithubResults.new.user_email(params[:github_handle])
    name = results[:name]
    email = results[:email]
    if email.nil?
      flash[:notice] = "The Github user you selected doesn't have an email address associated with their account."
      redirect_to root_path
    end
    ValidationMailer.invite(name, email, current_user.github_username).deliver_now
    redirect_to root_path
    flash[:notice] = 'Successfully sent invite!'
  end
end
