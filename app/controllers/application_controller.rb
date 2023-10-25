class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  def entity_errors_list(entity)
    entity.errors.map { |e| [e.attribute, e.message].join(' ') }
  end

  private

  def after_sign_in_path_for(resource)
    resource.admin? ? admin_tests_path : tests_path
  end

  protected

  def configure_permitted_parameters
    attributes = [:first_name, :last_name, :email]
    devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
    devise_parameter_sanitizer.permit(:account_update, keys: attributes)
  end
end
