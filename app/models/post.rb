class Post < ApplicationRecord
  # アソシエーション
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  # 新着順、古い順に並べ替えする際に使用
  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}

  # 画像を投稿する際に使用
  has_many_attached :post_images

  # バリデーション
  validates :title, presence: true
  validates :body, presence: true
  validate :validate_post_images
  validate :validate_number_of_files
  validates :tag_list, presence: true
  validates :address, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true

  # 投稿にユーザーがいいねをしているかを確認するためのメソッド
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  # 検索機能
  def self.looks(word)
    # 検索フォームに入力があるかを確認
    if word.blank?
      # 入力がない場合全ての投稿を表示
      @post = Post.all
    else
      # 入力があった場合、タイトルと説明文と場所・地名に入力された文字がある投稿を表示
      @post = Post.where(["title LIKE? OR body LIKE? OR address LIKE?", "%#{word}%", "%#{word}%", "%#{word}%"])
    end
  end

  # タグの区切りを"#"に変更
  ActsAsTaggableOn.delimiter = '#'

  private
  # 投稿画像の枚数制限のエラーメッセージ
  def validate_number_of_files
    return if post_images.length <= 5
    errors.add(:post_images, "には最大5枚まで添付できます")
  end
  # 画像の選択がされていない時のエラーメッセージ
  def validate_post_images
    if post_images.length == 0
      errors.add(:post_images, "を添付してください")
    end
  end

  # タグ情報を保存する
  acts_as_taggable
end
