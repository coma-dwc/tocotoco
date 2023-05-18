class Hashtag < ApplicationRecord

  validates :hashname, presence: true, length: { maximum: 50 }

  has_many :article_hashtags, dependent: :destroy
  has_many :articles, through: :article_hashtags

  #ハッシュタグ検索
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "hashname", "id", "updated_at"]
  end
end
