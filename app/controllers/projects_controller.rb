class ProjectsController < ApplicationController

    before_action :authenticate_user


  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(params.require(:project).permit(:name))
    if @project.save
    @project.memberships.create(user_id: current_user.id, role: "owner")

    flash[:notice] = "Project was successfully created"
    redirect_to projects_path
  else
    render :new
  end
  end

  def show
    @project = Project.find(params[:id])
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(params.require(:project).permit(:name))
    flash[:notice] = "Project was successfully updated"
    redirect_to project_path
    else
    render :edit
  end
  end

  def destroy
    Project.destroy(params[:id])
    flash[:notice] = "Project was successfully deleted"
    redirect_to projects_path
  end
end
