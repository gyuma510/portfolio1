class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
    "/remember_you/records"
  end

  def after_sign_out_path_for(resource)
    "/remember_you/records"
  end

  def after_inactive_sign_up_path_for(resource)
    "/remember_you/records"
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
