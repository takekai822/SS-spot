class Public::PostsController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      flash[:notice] = "投稿しました"
      redirect_to post_path(@post)
    else
      render "new"
    end
  end

  def index
    if params[:latest]
      #新着順で並び替え
      @posts = Post.latest.page(params[:page]).per(10)
    elsif params[:old]
      #古い順で並び替え
      @posts = Post.old.page(params[:page]).per(10)
    elsif params[:tag_name]
      #タグの絞り込み
      #タグがクリックされたらクリックされたタグの名前をtagge_with(タグの名前)メソッドで検索し絞り込みを行う
      @posts = Post.tagged_with("#{params[:tag_name]}").page(params[:page]).per(10)
    else
      #いいねの多い順で並び替え
      posts = Post.includes(:favorited_users).sort {|a, b| b.favorited_users.size <=> a.favorited_users.size}
      @posts = Kaminari.paginate_array(posts).page(params[:page]).per(10)
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "編集内容を更新しました"
      redirect_to post_path(@post)
    else
      render "edit"
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to posts_path
  end

  private
  def post_params
    params.require(:post).permit(:title, :body, :address, :latitude, :longitude, :tag_list, post_images: [])
  end

  #投稿者本人しか投稿を編集できないようにするためのアクション
  def ensure_correct_user
    @post = Post.find(params[:id])
    unless @post.user == current_user
      redirect_to request.referer
    end
  end
end
