class Admin::PostsController < ApplicationController
  def index
    @posts = Post.all.page(params[:page]).per(20)
  end

  def show
    @post = Post.find(params[:id])
  end
  
  #不適切な投稿の削除
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "不適切な投稿を削除しました。"
    redirect_to admin_posts_path
  end
end
