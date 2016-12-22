class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_group
    @current_group = Group.find(session[:group_id]) if session[:group_id]
  end
end
