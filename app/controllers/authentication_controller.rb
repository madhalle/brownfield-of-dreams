class AuthenticationController < ApplicationController

  def create
    auth = request.env['omniauth.auth']
    current_user.update(token: auth['credentials']['token'])
    require "pry"; binding.pry
    redirect_to dashboard_path
  end

end
