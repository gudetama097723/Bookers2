class Book < ApplicationRecord

  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments,dependent: :destroy
  has_many :book_tags, dependent: :destroy
  has_many :tags, through: :book_tags

  validates :title, presence: true
  validates :body,
    presence: true,
    length: { maximum: 200 }
  validates :rating, inclusion: { in: 1..5 }, allow_nil: true
  validate :rating_cannot_be_changed, on: :update

  def favorited_by?(user)
    favorites.exists?(book_id: id, user_id: user.id)
  end

  def rating_cannot_be_changed
    if rating_changed? && rating_was.present?
      errors.add(:rating, "は変更できません")
    end
  end
end
