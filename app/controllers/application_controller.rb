class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  def entity_errors_list(entity)
    entity.errors.map { |e| [e.attribute, e.message].join(' ') }
  end

  private

  def after_sign_in_path_for(resource)
    resource.is_a?(Admin) ? admin_tests_path : tests_path
  end
end
