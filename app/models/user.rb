class User < ApplicationRecord
  has_one_attached :profile_image
  has_many :sessions, dependent: :destroy
  has_many :favorites, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  has_many :books, dependent: :destroy

  validates :email_address, presence: true
  has_secure_password
  validates :password, length: { minimum: 6}, allow_blank: true
  validates :name,uniqueness: true,length: { minimum: 2, maximum: 20 }
  validates :introduction,length: { maximum: 50 }
end
