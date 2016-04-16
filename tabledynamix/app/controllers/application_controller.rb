class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def current_user
    if session[:customer_id]
      @current_user ||= Customer.find(session[:customer_id])
    elsif session[:owner_id]
      @current_user ||= Owner.find(session[:owner_id])
    end
  end
  helper_method :current_user

  def ensure_logged_in
    unless current_user
      #flash
      redirect_to new_sessions_url
    end
  end
end
