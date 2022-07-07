class Public::FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user

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

  private
  # ゲストユーザーの利用制限のアクション
  def ensure_guest_user
    if current_user.name == 'ゲストユーザー'
      redirect_to request.referer, notice: 'ゲストユーザーでは利用できない機能です'
    end
  end
end
