class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:update, :edit]
  
  def show
    @user = User.find(params[:id])
  end

  def edit
  end
  
  def update
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  def favorites
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user_id).pluck(:post_id)
    @favorites_posts = Post.find(favorites)
  end

  def quit
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :name_kana, :user_name, :profile_image, :email )
  end
  
  def ensure_correct_user
    @user = User.find(pamras[:id])
    unless @user == current_user
      redirect_to user_path(@user)
    end
  end
end
