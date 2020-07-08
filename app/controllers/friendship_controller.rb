class FriendshipController < ApplicationController
  def create
    friendship = current_user.friendships.create(friend_id: params[:friend_id])
    flash[:success] = 'Friend Added' if friendship.save
    flash[:error] = 'Unable to Add Friend' unless friendship.save
    redirect_to dashboard_path
  end
end
