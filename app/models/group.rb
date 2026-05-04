class Group < ApplicationRecord
  belongs_to :owner, class_name: "User"

  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users

  has_one_attached :image

  validates :name, presence: true

  def joined_by?(user)
    group_users.exists?(user_id: user.id)
  end
end
