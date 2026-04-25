class User < ApplicationRecord
  has_one_attached :profile_image
  has_many :sessions, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments,dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  has_many :books, dependent: :destroy

  validates :email_address, presence: true
  has_secure_password
  validates :password, length: { minimum: 6}, allow_blank: true
  validates :name,uniqueness: true,length: { minimum: 2, maximum: 20 }
  validates :introduction,length: { maximum: 50 }

  def get_profile_image(width, height)
  if profile_image.attached?
    profile_image
  else
    "noimage.jpg"
  end
end

  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :relationships,source: :followed

  has_many :reverse_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :reverse_relationships,source: :follower

  def follow(user)
    relationships.create(followed_id: user.id)
  end

  def unfollow(user)
    relationships.find_by(followed_id: user.id)&.destroy
  end

  def following?(user)
    followings.include?(user)
  end
end


