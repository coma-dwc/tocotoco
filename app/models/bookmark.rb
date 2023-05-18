class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :article

  #一つのユーザーは同じ投稿に対して一回しかブックマークが出来ない
  validates :user_id, uniqueness: { scope: :article_id }
end
