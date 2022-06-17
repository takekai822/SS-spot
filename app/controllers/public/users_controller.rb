class Public::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show, :favorites]
  before_action :ensure_correct_user, only: [:update, :edit, :quit, :withdraw]

  # ユーザー詳細
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.all.page(params[:page]).per(10)
  end

  # ユーザー編集
  def edit
  end

  # ユーザーアップデート
  def update
    if @user.update(user_params)
      flash[:notice] = "ユーザー情報を更新しました"
      redirect_to user_path(@user)
    else
      render "edit"
    end
  end

  # いいねした投稿の一覧
  def favorites
    @user = User.find(params[:id])
    #user_idに@userが存在するレコードを全て取得し、その投稿のpost_idも一緒に取得、そのpost_idをfavoritesに代入
    favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
  end

  # 退会
  def quit
  end

  # 退会機能
  def withdraw
    #ユーザーステータスをfalseからtrueへ更新
    @user.update(is_deleted: true)
    #セッション情報を全てリセットする
    reset_session
    flash[:notice] = "退会処理を行いました"
    redirect_to root_path
  end

  private
  # ストロングパラメータ
  def user_params
    params.require(:user).permit(:name, :name_kana, :user_name, :profile_image, :email )
  end

  #本人しかユーザー情報を編集できないようにするためのアクション
  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(@user)
    end
  end
end
