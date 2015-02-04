class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale, :set_user

  protected
  def set_locale
    I18n.locale = params[:locale] || session[:locale] || I18n.default_locale
    session[:locale] = I18n.locale
  end

  def set_user
    if session[:user_session_name].blank?
      session[:user_session_name] = 0
    end
    @auth_user = AuthUser.new(session[:user_session_name])
  end
end
