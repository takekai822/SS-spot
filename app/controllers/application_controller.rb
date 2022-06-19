class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameter, if: :devise_controller?

  # ログイン後のリダイレクト先
  def after_sign_in_path_for(resource)
    if admin_signed_in?
      # 管理者側
      admin_users_path
    else
      # ユーザー側
      user_path(resource)
    end
  end

  # ログアウト後のリダイレクト先
  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :admin
      # 管理者側
      new_admin_session_path
    else
      # ユーザー側
      root_path
    end
  end


  protected
  def configure_permitted_parameter
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :name_kana, :user_name, :profile_image])
  end
end
