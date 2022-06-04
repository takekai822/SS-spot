class Post < ApplicationRecord
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  has_many_attached :post_images
  
  validates :title, presence: true
  validates :body, presence: true
  validates :post_images, presence: true
  
  #タグ情報を保存する
  acts_as_taggable
end
