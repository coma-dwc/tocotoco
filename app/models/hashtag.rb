class Hashtag < ApplicationRecord

  validates :hashname, presence: true, length: { maximum: 50 }
  # has_and_belongs_to_many :articles
  has_many :article_hashtags, dependent: :destroy
  has_many :articles, through: :article_hashtags


end
