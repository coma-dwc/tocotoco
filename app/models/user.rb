class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :bookmarks, dependent: :destroy
         has_many :comments, dependent: :destroy
         has_many :articles, dependent: :destroy
         has_many :todos, dependent: :destroy

        validates :name, presence: true
        validates :email, presence: true

  def self.guest
    find_or_create_by!(name: 'guestuser' ,email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end
end
