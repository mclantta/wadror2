class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :is_admin

  def current_user
    return nil if session[:user_id].nil?
    User.find(session[:user_id])
  end

  def is_admin
    return true if current_user and current_user.admin == true
  end

  def ensure_that_signed_in
    redirect_to signin_path, notice:'you should be signed in' if current_user.nil?
  end

  def ensure_that_admin
    redirect_to signin_path, notice:'you should be signed in as admin' if current_user.nil? or current_user.admin == nil
  end  
end
