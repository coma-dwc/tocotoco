class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  #新規ユーザー登録後の遷移先
  # def after_sign_up_path_for(resource)
  #   if current_user
  #     users_my_page_path
  #   end
  # end

  # #サインイン後の遷移先
  # def after_sign_in_path_for(resource)
  #   if resource_or_scope == :current_user
  #     users_my_page_path #ユーザーのマイページ
  #   elsif resource_or_scope == :admin
  #     admin_users_path #adminのユーザー一覧ページ
  #   else
  #     root_path #publicのトップページ
  #   end
  # end

  # #ログアウト後の遷移先
  # def after_sign_out_path_for(resource_or_scope)
  #   if resource_or_scope == :current_user
  #     root_path #publicのトップページ
  #   elsif resource_or_scope == :admin
  #     new_admin_session_path #adminの新規ユーザー登録ページ
  #   else
  #     root_path #publicのトップページ
  #   end
  # end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
