class AuthenticationController < ApplicationController

  def create
    auth = request.env['omniauth.auth']
    current_user.token = auth['omniauth.auth']['credentials']['token']
    current_user.save
    redirect_to dashboard_path
  end

end
