class Message < ApplicationRecord
  belong_to :room
  belong_to :user
  validates :content, presence: true, length: { maximum: 140 }
end
