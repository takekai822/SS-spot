class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  # 管理者側 投稿一覧
  def index
    @posts = Post.all.page(params[:page]).per(20)
    # 投稿数
    @post_count = Post.all.count
  end

  # 管理者側 投稿詳細
  def show
    @post = Post.find(params[:id])
  end

  # 不適切な投稿の削除
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "不適切な投稿を削除しました"
    redirect_to admin_posts_path
  end
end
