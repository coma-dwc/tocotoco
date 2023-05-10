class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  # 新規ユーザー登録後の遷移先
  # def after_sign_up_path_for(resource)
  #   if current_user
  #     users_my_page_path
  #   end
  # end


  private
  #サインイン後の遷移先
  def after_sign_in_path_for(resource_or_scope)
     if resource_or_scope.is_a?(Admin)
        admin_root_path #adminのサインイン後の遷移先
     else
         users_my_page_path #publicのサインイン後の遷移先
     end
  end

  #ログアウト後の遷移先
  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :user
        about_path
    elsif resource_or_scope == :admin
        new_admin_session_path
    else
        about_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
