class RoomsController < ApplicationController
  def create
    user = User.find(params[:user_id])

    unless mutual_follow?(Current.user, user)
      redirect_back fallback_location: root_path, alert: "相互フォローのみDM可能です"
      return
    end

    room = find_or_create_room(Current.user, user)
    redirect_to room_path(room), status: :see_other
  end

  def show
    @room = Room.find(params[:id])
    @messages = @room.messages
  end


  private

  def mutual_follow?(user1, user2)
    user1.following?(user2) && user2.following?(user1)
  end

  def find_or_create_room(user1, user2)
    room = Room.where(user1: user1, user2: user2)
               .or(Room.where(user1: user2, user2: user1))
               .first

    return room if room

    Room.create!(user1: user1, user2: user2)
  end
end