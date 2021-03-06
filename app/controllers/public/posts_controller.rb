class Public::PostsController < ApplicationController
  before_action :authenticate_user! , except: [:show, :index]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  before_action :ensure_guest_user, only: [:create, :edit, :update, :destroy]

  # 新規投稿
  def new
    @post = Post.new
  end

  # 投稿
  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      flash[:notice] = "投稿しました"
      redirect_to post_path(@post)
    else
      render "new"
    end
  end

  # 投稿一覧
  def index
    if params[:latest]
      # 新着順で並び替え
      @posts = Post.latest.page(params[:page]).per(10)
      # 投稿数
      @post_count = Post.all.count
    elsif params[:old]
      # 古い順で並び替え
      @posts = Post.old.page(params[:page]).per(10)
      # 投稿数
      @post_count = Post.all.count
    elsif params[:favorite]
      # いいねの多い順で並び替え
      @posts = Post.left_joins(:favorites).group(:id).order('count(favorites.post_id) desc').page(params[:page]).per(10)
      # 投稿数
      @post_count = Post.all.count
    elsif params[:tag_name]
      # タグの絞り込み
      # タグがクリックされたらクリックされたタグの名前をtagge_with(タグの名前)メソッドで検索し絞り込みを行う
      @posts = Post.tagged_with("#{params[:tag_name]}").page(params[:page]).per(10)
      # 投稿数
      @post_count = Post.tagged_with("#{params[:tag_name]}").count
    else
      @posts = Post.all.page(params[:page]).per(10)
      # 投稿数
      @post_count = Post.all.count
    end
  end

  # 投稿詳細
  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  # 投稿編集
  def edit
  end

  # 投稿アップデート
  def update
    if @post.update(post_params)
      flash[:notice] = "編集内容を更新しました"
      redirect_to post_path(@post)
    else
      render "edit"
    end
  end

  # 投稿削除
  def destroy
    @post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to posts_path
  end

  private
  # ストロングパラメータ
  def post_params
    params.require(:post).permit(:title, :body, :address, :site, :latitude, :longitude, :tag_list, post_images: [])
  end

  # 投稿者本人しか投稿を編集できないようにするためのアクション
  def ensure_correct_user
    @post = Post.find(params[:id])
    unless @post.user == current_user
      redirect_to request.referer
    end
  end

  # ゲストユーザーの利用制限のアクション
  def ensure_guest_user
    if current_user.name == 'ゲストユーザー'
      redirect_to posts_path, notice: 'ゲストユーザーでは利用できない機能です'
    end
  end
end
