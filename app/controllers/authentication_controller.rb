class AuthenticationController < ApplicationController
  def create
    @user = User.find_or_create_from_auth(request.env['omniauth.auth'])
    require "pry"; binding.pry
    if @user
      session[:user_id] = @user.id
      redirect_to dashboard_path
    else
      redirect_to dashboard_path
    end
  end

end
