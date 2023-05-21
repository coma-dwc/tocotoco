class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :comments, dependent: :destroy
         has_many :articles, dependent: :destroy
         has_many :todos, dependent: :destroy
         has_many :bookmarks, dependent: :destroy

        validates :name, presence: true
        validates :email, presence: true

  def self.guest
    find_or_create_by!(name: 'guestuser' ,email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end

  has_one_attached :profile_image

  def is_not_guest?
    self.name != 'guestuser'
  end

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'default_image.jpg'
  end

  def own?(object)
    id == object.user_id
  end

  def bookmark(article)
    bookmarks_articles << article
  end

  def unbookmark(article)
    bookmark_articles.delete(article)
  end

  def bookmark?(article)
    bookmark_articles.include?(article)
  end
end
