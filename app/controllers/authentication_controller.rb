class AuthenticationController < ApplicationController

  def create
    auth = request.env['omniauth.auth']
    current_user.update(token: auth['credentials']['token'])
    require "pry"; binding.pry
    redirect_to dashboard_path
  end

  # private
  # def permitted_params
  #   params.permit(:user => [:username, :email])
  # end

end
