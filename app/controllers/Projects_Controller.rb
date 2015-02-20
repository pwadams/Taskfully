class ProjectsController < ApplicationController

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(params.require(:project).permit(:name))
    @project.save
    flash[:notice] = "Project was successfully created"
    redirect_to projects_path
  end

  def show
    @project = Project.find(params[:id])
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    @project.update(params.require(:project).permit(:name))
    flash[:notice] = "Project was successfully updated"
    redirect_to project_path
  end

  def destroy
    Project.destroy(params[:id])
    flash[:notice] = "Project was successfully deleted"
    redirect_to projects_path
  end
end
