class Room < ApplicationRecord
  has_many :message, dependent: :destroy

  belong_to :user1, class_name: "User"
  belong_to :user2, class_name: "User"

  def mutual_follow?(user, other_user)
    user.following?(other_user) && other_user.following?(user)
  end

  def find_or_create_room(user, other_user)
    Room.where(user1: user, user2: other_user)
    .or(Room.where(user1: other_user, user2: user))
    .first_or_create(user1: user, user2: other_user)
  end

end
