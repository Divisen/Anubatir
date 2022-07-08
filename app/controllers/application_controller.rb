class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :is_builder, :company_name, :address])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :grade_of_contractor, :avatar, :username, :logo])
  end

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end
end
