class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:update, :edit, :quit, :withdraw]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.all.page(params[:page]).per(10)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render "edit"
    end
  end

  def favorites
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: @user_id).pluck(:post_id)
    @favorites_posts = Post.find(favorites)
  end

  def quit
  end

  def withdraw
    #ユーザーステータスをfalseからtrueへ更新
    @user.update(is_deleted: true)
    #セッション情報を全てリセットする
    reset_session
    flash[:notice] = "退会処理を行いました"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :name_kana, :user_name, :profile_image, :email )
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(@user)
    end
  end
end
