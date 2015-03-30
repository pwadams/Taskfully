class ProjectsController < ApplicationController

    before_action :authenticate_user
    before_action :find_project, only: [:show, :edit, :update, :destroy]
    before_action :ensure_project_member_or_admin, only: [:edit, :show, :update, :destroy]
    before_action :ensure_project_owner_or_admin, only: [:edit, :update, :destroy]


  def index
    if current_user.admin
      @project = Project.all
    else
      @projects = current_user.projects
    end

  #   tracker_api = TrackerAPI.new
  #  @tracker_projects ||= tracker_api.projects(current_user.pivotal_token) if current_user.pivotal_token
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
    @project.memberships.create(user_id: current_user.id, role: "Owner")
    flash[:notice] = "Project was successfully created"
    redirect_to project_tasks_path(@project)
    else
    render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @project.update(project_params)
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

  private

  def project_params
    params.require(:project).permit(:name)
  end

  def find_project
    @project = Project.find(params[:id])
  end
end
