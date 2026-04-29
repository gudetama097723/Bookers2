class RoomsController < ApplicationController
  def create
    user = User.find(params[:user_id])

    unless mutual_follow?(Current.user, user)
      redirect_back fallback_location: root_path, alert: "相互フォローのみDM可能です"
      return
    end

    room = find_or_create_room(Current.user, user)
    redirect_to room_path(room)
  end

  private

  def mutual_follow?(user1, user2)
    user1.following?(user2) && user2.following?(user2)
  end
end
