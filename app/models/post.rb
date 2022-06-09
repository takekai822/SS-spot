class Post < ApplicationRecord
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  #いいねの多い順に並べ替えする際に使用
  has_many :favorited_users, through: :favorites, source: :user
  #新着順、古い順に並べ替えする際に使用
  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}

  has_many_attached :post_images

  validates :title, presence: true
  validates :body, presence: true
  validate :validate_post_images
  validate :validate_number_of_files
  validates :tag_list, presence: true
  validates :address, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true

  #投稿にユーザーがいいねをしているかを確認するためのメソッド
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.looks(word)
    if word != ""
      @post = Post.where(["title LIKE? OR body LIKE?", "%#{word}%", "%#{word}%"])
    else
      @post = Post.all
    end
  end
  
  #タグの区切りを"#"に変更
  ActsAsTaggableOn.delimiter = '#'

  private
  #投稿画像の枚数制限のエラーメッセージ
  def validate_number_of_files
    return if post_images.length <= 5
    errors.add(:post_images, "には最大5枚まで添付できます")
  end
  #画像の選択がされていない時のエラーメッセージ
  def validate_post_images
    if post_images.length == 0
      errors.add(:post_images, "を添付してください")
    end
  end

  #タグ情報を保存する
  acts_as_taggable
end
