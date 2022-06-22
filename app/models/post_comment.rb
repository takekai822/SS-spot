class PostComment < ApplicationRecord
  # アソシエーション
  belongs_to :user
  belongs_to :post

  validates :comment, presence: true
  validates :rate, presence: true
end
