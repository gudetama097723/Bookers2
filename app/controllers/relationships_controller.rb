class RelationshipsController < ApplicationController
  def create
    user = User.find(params[:user_id])
    Current.user.follow(user)
    redirect_back fallback_location: users_path
  end

  def destroy
    user = User.find(params[:user_id])
    Current.user.unfollow(user)
    redirect_back fallback_location: users_path
  end
end
