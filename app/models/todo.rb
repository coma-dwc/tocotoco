class Todo < ApplicationRecord

  belongs_to :user

  validates :task, presence: true, length: { maximum: 20 }
  validates :user_id, presence: true
end
