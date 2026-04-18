class User < ApplicationRecord
  has_one_attached :image
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  has_many :books, dependent: :destroy

  validates :email_address, presence: true
  has_secure_password
  validates :password, length: { minimum: 6}, allow_blank: true
  validates :name, presence: true
  validates :name, length: { minimum: 2 }, allow_blank: true

end
