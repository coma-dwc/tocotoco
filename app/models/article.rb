class Article < ApplicationRecord

  belongs_to :user
  has_many :bookmarks, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :images, dependent: :destroy
  has_many :article_hashtags, dependent: :destroy
  has_many :hashtags, through: :article_hashtags

  validates :user_id, presence: true
  validates :title, presence: true
  validates :content, presence: true

  after_create do
    article = Article.find_by(id: self.id)
    hashtags = self.content.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    hashtags.uniq.map do |hashtag|
      # ハッシュタグは先頭の#を外した上で保存
      tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
      article.hashtags << tag
    end
  end
  #更新アクション
  before_update do
    article = Article.find_by(id: self.id)
    article.hashtags.clear
    hashtags = self.content.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    hashtags.uniq.map do |hashtag|
      tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
      article.hashtags << tag
    end
  end


  def bookmarked_by?(user)
    bookmarks.where(user_id: user).exists?
  end
end
