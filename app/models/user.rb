class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # アソシエーション
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  # バリデーション
  validates :name, presence: true, length: {minimum: 2, maximum: 30}
  validates :name_kana, presence: true, length: {minimum: 2,maximum: 30}
  validates :user_name, presence: true, length: {minimum: 2,maximum: 30}

  # プロフィール画像を登録する際に使用
  has_one_attached :profile_image

  # プロフィール画像の表示に関するメソッド
  def get_profile_image
    # プロフィール画像が添付されているかを確認し、添付されていた場合その画像を表示し、添付されていない場合はno_image.jpgを表示
    (profile_image.attached?) ? profile_image : "no_image.jpg"
  end
end
