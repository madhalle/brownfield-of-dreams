class FriendshipController < ApplicationController

  def create
    friendship = current_user.friendships.create(friend_id: params[:friend_id])
    if friendship.save
      flash[:success] = "Friend Added"
    else
      flash[:success] = "Unable to Add Friend"
    end
    redirect_to dashboard_path
  end

end
