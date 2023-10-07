class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  def entity_errors_list(entity)
    entity.errors.map { |e| [e.attribute, e.message].join(' ') }
  end

  helper_method :current_user, :logged_in?

  private

  def authenticate_user!
    return if current_user

    session[:redirect_to_url] = request.url
    redirect_to login_path, alert: 'Please login'
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end
end
