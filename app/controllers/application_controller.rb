class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_group
    @current_group = Group.find(session[:group_id]) if session[:group_id]
  end

  def signed_in?
    current_group.present?
  end

  def check_if_signed_in
    unless signed_in?
      redirect_to login_url
      flash[:danger] = t('.application.login')
    end
  end

  def same_group?
    signed_in? && params[:group_id].to_i == current_group.id
  end

  def scope_to_current_group
    @group = current_group
    unless same_group?
      redirect_to root_url
      flash[:danger] = t('application.scope_to_current_group.access_prohibited')
    end
  end
end
