class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameter, if: :devise_controller?

  def after_sign_in_path_for(resource)
    if admin_signed_in?
      admin_users_path
    else
      user_path(resource)
    end
  end

  def after_sign_out_path_for(resource)
    root_path
  end


  protected
  def configure_permitted_parameter
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :name_kana, :user_name, :profile_image])
  end
end
