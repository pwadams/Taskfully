class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :authenticate_user

    def authenticate_user
      if current_user
      flash[:notice] = "You must register or log in before you can do that!"
      redirect_to root_path
    end
  end

    def current_user
    if session[:user_id].present?
      User.find(session[:user_id])
    end
  end
end
