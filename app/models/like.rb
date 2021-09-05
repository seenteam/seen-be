class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  belongs_to :user

  validates :user_id, :post_id, presence: true
end
