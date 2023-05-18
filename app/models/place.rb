class Place < ApplicationRecord

  has_many :articles, dependent: :destroy

  validates :prefectures, presence: true

end
