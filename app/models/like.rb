class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  belongs_to :user

  validates :user_id, :post_id, presence: true

  # def self.count(post_id)
  #   self.select('post_id, sum (post_id)').group('post_id').where('post_id = 1')
  # end
end
