class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :first_name, :last_name, :birthday, presence: true
  validates :email, :user_name, uniqueness: true, presence: true
  validates_numericality_of :phone_number
  # look into validation for phone number formatting
  # look into ValidatesTimeliness gem for birthday validation and/or age restriction
  validates_format_of :email, with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
end