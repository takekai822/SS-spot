# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :user_state, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

# ゲストユーザーログイン
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to user_path(user), notice: 'ゲストユーザーでログインしました'
  end

  protected
# 会員ステータスの確認メソッド
  def user_state
    # 入力されたメールアドレスからアカウントを取得
    @user = User.find_by(email: params[:user][:email])
    # メールアドレスとパスワードが一致しなかった場合、処理を終了する
    return if !@user
    # 取得したアカウントのパスワードと入力されたパスワードが一致しているかつ、アカウントのユーザーステータス(is_deleted)がtrue(退会済み)だった場合、下の処理を行う
    if @user.valid_password?(params[:user][:password]) && (@user.is_deleted == true)
      flash[:notice] = "退会済みのアカウントです。再度ご登録をしてご利用ください。"
      redirect_to new_user_registration_path
    end
  end
end
