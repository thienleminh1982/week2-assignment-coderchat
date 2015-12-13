class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :signed_in?

  def current_user
    return nil if session[:user_id].nil?
    @current_user ||= User.find(session[:user_id])
  end


  def signed_in?
    current_user
  end

  def require_login
    unless signed_in?
      flash[:warning] = 'You must sign in to see this page!'
      redirect_to sessions_new_path
    end
  end

end
