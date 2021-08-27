class Post < ApplicationRecord
  belongs_to :user

  validates :user_id, :content, presence: true
end
