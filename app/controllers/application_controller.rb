class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def after_sign_out_path_for(resource)
    case resource
    when :user
      new_user_session_path
    when :teacher
      new_teacher_session_path
    when :admin
      new_admin_session_path
    else
      new_user_session_path
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: %i[name]
  end
end
