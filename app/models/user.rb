class User < ApplicationRecord
  before_save {email.downcase!}
  validates :name, presence: true,length: {maximum: Settings.user_max_length_name}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: Settings.user_max_length_email},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true, length: {minimum: Settings.user_min_length_password}, 
    allow_nil: true
end