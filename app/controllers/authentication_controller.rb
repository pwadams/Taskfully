class AuthenticationController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "You have successfully signed in."
      if session[:previous_page] == nil
        redirect_to projects_path
      else
        redirect_to session[:previous_page]
      end
    else
      flash[:danger] = "Email/Password combination is invalid."
      render :new
    end
  end

  def destroy
    session.clear
    flash[:notice] = "You have successfully signed out"
    redirect_to root_path
  end
end
