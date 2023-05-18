class Article < ApplicationRecord
  has_many_attached :images
  # has_and_belongs_to_many :hashtags

  geocoded_by :address
  after_validation :geocode

  belongs_to :user
  belongs_to :place
  has_many :bookmarks, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :article_hashtags, dependent: :destroy
  has_many :hashtags, through: :article_hashtags
  # has_many :article_images, dependent: :destroy
  # accepts_attachments_for :article_images, attachment: :image

  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true, length: { maximum: 1000 }

  # after_save do
  #   article = Article.find_by(id: id)
  #   hashtags = content.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
  #   hashtags.uniq.map do |hashtag|
  #     # ハッシュタグは先頭の#を外した上で保存
  #     tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
  #     article.hashtags << tag
  #   end
  # end
  #更新アクション
  after_save do
    article = Article.find_or_initialize_by(id: id)
    article.hashtags.clear unless article.new_record?
    hashtags = content.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    hashtags.uniq.map do |hashtag|
      tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
      article.hashtags << tag
    end
  end


  # has_one_attached :profile_image

  # def get_profile_image
  #   (profile_image.attached?) ? profile_image : 'default_image.jpg'
  # end

  def get_article_image(width, height)
    if images.present?
      images.variant(resize_to_fit: [width, height]).processed
    else
      ''
    end
  end

  def bookmarked_by?(user)
    bookmarks.where(user_id: user).exists?
  end

  #キーワード検索
  def self.ransackable_attributes(auth_object = nil)
    ["content", "created_at", "hashtag_id", "id", "place_id", "title", "updated_at", "user_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["article_hashtags", "bookmarks", "comments", "hashtags", "images_attachments", "images_blobs", "user"]
  end

end
