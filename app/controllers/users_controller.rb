class UsersController < ApplicationController

  before_action :authenticate_user


  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
      @user = User.new(user_params)
      if @user.save
      flash[:notice] = "User was successfully created"
      redirect_to users_path
    else
      render :new
  end
end

  def edit
    @user = User.find(params[:id])
    unless @user == current_user || current_user.admin
    render file: 'public/404.html', status: :not_found, layout: false
  end
end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
       flash[:notice] = "User was successfully updated"

       redirect_to users_path
       else
      render :edit
  end
end

  def destroy
    User.destroy(params[:id])
    flash[:notice] = "User was successfully deleted"
    session[:user_id] = nil
    redirect_to users_path
  end

  private

  def user_params

    if current_user.admin
      params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation,:admin)
    else

    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
  end
end
