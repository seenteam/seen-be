class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :followers, dependent: :destroy
  has_many :friends, through: :followers, foreign_key: :friend_id

  validates :first_name, :last_name, :birthday, presence: true
  validates :email, :user_name, uniqueness: true, presence: true
  # look into validation for phone number formatting
  # look into ValidatesTimeliness gem for birthday validation and/or age restriction
  validates_format_of :email, with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
end
