class Image < ApplicationRecord

  belongs_to :article

  has_many_attached :images

end
