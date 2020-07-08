class WelcomeController < ApplicationController
  def index
    @tutorials = if params[:tag] && current_user
                   Tutorial.tagged_with(params[:tag]).paginate(page: params[:page], per_page: 5)
                 elsif current_user
                   Tutorial.all.paginate(page: params[:page], per_page: 5)
                 else
                   Tutorial.hide_classroom_content.paginate(page: params[:page], per_page: 5)
                 end
  end
end
