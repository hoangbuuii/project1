class User < ApplicationRecord
  has_many :microposts, dependent: :destroy

  before_save {email.downcase!}
  validates :name, presence: true,length: {maximum: Settings.user_max_length_name}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: Settings.user_max_length_email},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true, length: {minimum: Settings.user_min_length_password}, 
    allow_nil: true

  scope :select_id_name_email, ->{select :id, :name, :email}
  scope :order_created_at, ->{order :created_at}

  def User.digest string
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
      BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
