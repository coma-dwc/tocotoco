class Article < ApplicationRecord

  belongs_to :user
  has_many :bookmarks, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :hashtags, dependent: :destroy
  has_many :images, dependent: :destroy

  validates :user_id, presence: true
  validates :title, presence: true
  validates :content, presence: true


  def bookmarked_by?(user)
    bookmarks.where(user_id: user).exists?
  end
end
