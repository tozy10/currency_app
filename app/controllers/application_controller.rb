class ApplicationController < ActionController::Base
  before_action :devise_sanitized_params, if: :devise_controller?

  private

  def devise_sanitized_params
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(devise_permitted_params) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(devise_permitted_params) }
  end

  def devise_permitted_params
    %i[first_name last_name email password password_confirmation current_password]
  end

  protected

  def after_sign_in_path_for(_resource)
    dashboard_path
  end

  def after_update_path_for(_resource)
    dashboard_path
  end
  
  def after_sign_up_path_for(_resource)
    dashboard_path
  end
end
