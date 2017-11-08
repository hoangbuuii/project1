class Micropost < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :title, presence: true, length: {maximum:Settings.post_max_length_title}
  validates :content, presence: true, length: {maximum:Settings.post_max_length_content}
  scope :order_by_created_at_desc, ->{order created_at: :desc}
end
