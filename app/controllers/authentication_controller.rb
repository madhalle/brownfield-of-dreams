class AuthenticationController < ApplicationController

  def create
    auth = request.env['omniauth.auth']
    current_user.update(token: auth['credentials']['token'])
    current_user.update(github_username: auth['extra']['raw_info']['login'])
    redirect_to dashboard_path
  end


end
