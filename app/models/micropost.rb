class Micropost < ApplicationRecord
  belongs_to :user
  has_many :comments
  validates :user_id, presence: true
  validates :title, presence: true, length: {maximum:Settings.post_max_length_title}
  validates :content, presence: true, length: {maximum:Settings.post_max_length_content}
  scope :order_by_created_at_desc, ->{order created_at: :desc}
  scope :feed, (lambda do |following_ids, id|
    where "user_id IN (?) OR user_id = ?", following_ids, id
  end)
end
