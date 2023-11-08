class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :set_locale

  def entity_errors_list(entity)
    entity.errors.map { |e| [entity.class.human_attribute_name(e.attribute), e.message].join(' ') }.uniq
  end

  def default_url_options
    if params[:lang] && !params[:lang]&.to_sym.eql?(I18n.default_locale)
      { lang: I18n.locale }
    else
      {}
    end
  end

  private

  def after_sign_in_path_for(resource)
    resource.admin? ? admin_tests_path : tests_path
  end

  def set_locale
    I18n.locale = I18n.locale_available?(params[:lang]) ? params[:lang] : I18n.default_locale
  end

  protected

  def configure_permitted_parameters
    attributes = [:first_name, :last_name, :email]
    devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
    devise_parameter_sanitizer.permit(:account_update, keys: attributes)
  end
end
