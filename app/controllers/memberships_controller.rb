class MembershipsController < ApplicationController
  before_action :authenticate_user


  before_action do
    @project = Project.find(params[:project_id])
  end

  def index
    @membership = @project.memberships.new
    @memberships = @project.memberships
  end

  def create
    @membership = @project.memberships.new(params.require(:membership).permit(:user_id, :project_id, :role))
    if @membership.save
      flash[:notice] = "#{@membership.user.full_name} was successfully added."
      redirect_to project_path(@project)
    else
      render :index
    end
  end

  def show
    @membership = @project.memberships.find(params[:id])
  end

  def edit
    @membership = project.memberships.find(params[:id])
  end

  def update
    @membership = @project.memberships.find(params[:id])
    if @membership.save(params.require(:membership).permit(:user_id, :project_id, :role))
      flash[:notice] = "#{@membership.user.full_name} was successfully updated."
      redirect_to project_memberships_path(membership.project_id)
    else
      render :index
    end
  end

  def destroy
    membership = @project.memberships.find(params[:id])
    membership.destroy
    redirect_to project_memberships_path(@project)
    flash[:success] = membership.user.full_name + " was successfully removed."
  end
end
