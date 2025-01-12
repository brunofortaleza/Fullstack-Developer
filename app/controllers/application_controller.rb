class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    if resource.admin?
      dashboard_path
    else
      user_path(resource)
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:full_name, :role, :avatar_image])
    devise_parameter_sanitizer.permit(:account_update, keys: [:full_name, :role, :avatar_image])
  end
end
