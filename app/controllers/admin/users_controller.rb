class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  # 管理者側 ユーザー一覧
  def index
    @users = User.all.page(params[:page]).per(10)
    # ユーザー数
    @user_count = User.all.count
  end

  # 管理者側 ユーザー詳細
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.all.page(params[:page]).per(10)
    # ユーザーの投稿数
    @post_count = @user.posts.all.count
  end

  # 管理者側 ユーザー編集
  def edit
    @user = User.find(params[:id])
  end

  # 管理者側 ユーザーアップデート
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    flash[:notice] = "会員ステータスを変更しました"
    redirect_to admin_users_path
  end

  private
  # ストロングパラメータ
  def user_params
    params.require(:user).permit(:is_deleted)
  end
end
