class Public::FavoritesController < ApplicationController
  before_action :authenticate_user!

  # いいねをつける
  def create
    @post = Post.find(params[:post_id])
    @favorite = current_user.favorites.new(post_id: @post.id)
    @favorite.save
    render "public/favorites/favorite"
  end

  # いいねを消す
  def destroy
    @post = Post.find(params[:post_id])
    @favorite = current_user.favorites.find_by(post_id: @post.id)
    @favorite.destroy
    render "public/favorites/favorite"
  end
end
