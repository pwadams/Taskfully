class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :authenticate_user

  def authenticate_user
    unless current_user
    flash[:idiot] = "You must register or log in before you can do that!"
    redirect_to root_path
    end
  end

  # def current_user
  #   if session[:user_id].present?
  #   User.find(session[:user_id])
  #   end
  # end
  def current_user
  @current_user ||= User.find(session[:user_id]) if session[:user_id].present?
  end

  def ensure_project_owner
    unless current_user.is_owner?(@project)
      flash[:idiot] = "You do not have access"
      redirect_to project_path(@project)
    end
  end

  def ensure_project_member
    unless current_user.is_member?(@project)
    flash[:idiot] = "You do not have access to that project"
    redirect_to projects_path
    end
  end
end
