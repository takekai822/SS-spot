class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :name, presence: true, length: {minimum: 2, maximum: 30}
  validates :name_kana, presence: true, length: {minimum: 2,maximum: 30}
  validates :user_name, presence: true, length: {minimum: 2,maximum: 30}

  has_one_attached :profile_image



  def get_profile_image
    (profile_image.attached?) ? profile_image : "no_image.jpg"
  end
end
