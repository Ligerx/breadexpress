class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  rescue_from ActiveRecord::RecordNotFound do |exception|
    redirect_to home_path, error: "Record not found in the system."
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: 'You are not authorized to take this action'
  end


  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def logged_in?
    current_user
  end
  helper_method :logged_in?

  def check_login
    if current_user.nil?
      redirect_to login_url, alert: 'Please login to view this page'
      return false
    else
      return true
    end
  end
  

end
