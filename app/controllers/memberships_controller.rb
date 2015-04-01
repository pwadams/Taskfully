class MembershipsController < ApplicationController

  before_action :find_project
  before_action :set_membership, only: [:update, :destroy]
  before_action :ensure_one_project_owner, only: [:update, :destroy]
  before_action :ensure_project_owner_or_admin, only: [:edit, :update, :destroy]
  before_action :ensure_project_member_or_admin, only: [:edit, :update, :show, :index]

  def index
    @membership = @project.memberships.new
    @memberships = @project.memberships
  end

  def create
    @membership = @project.memberships.new(membership_params)
    if @membership.save
      flash[:notice] = "#{@membership.user.full_name} was successfully added."
      redirect_to project_memberships_path(@project)
    else
      render :index
    end
  end

  def show
    @membership = @project.memberships.find(params[:id])
  end

  def edit
    @membership = @project.memberships.find(params[:id])
  end

  def update
    @membership = @project.memberships.find(params[:id])
    if @membership.update(membership_params)
      flash[:notice] = "#{@membership.user.full_name} was successfully updated."
      redirect_to project_memberships_path(@project)
    else
      render :index
    end
  end

  def destroy
    membership = @project.memberships.find(params[:id])
    membership.destroy
    redirect_to projects_path(@project)
    flash[:notice] = membership.user.full_name + " was successfully removed."

  end

  private

  def membership_params
    params.require(:membership).permit(:user_id, :project_id, :role)
  end

  def find_project
    @project = Project.find(params[:project_id])
  end

  def set_membership
    @membership = Membership.find(params[:id])
  end

  def ensure_one_project_owner
    if @membership.role == "Owner" && @project.memberships.where(role: "Owner").count <= 1
      redirect_to project_memberships_path(@project)
      flash[:idiot] = 'Project must have at least one owner'
    end
  end
end
