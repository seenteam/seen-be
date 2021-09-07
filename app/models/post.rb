class Post < ApplicationRecord
  belongs_to :user
  has_many :likes

  validates :user_id, :content, presence: true
end
