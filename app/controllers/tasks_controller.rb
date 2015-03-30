class TasksController < ApplicationController

      before_action :find_project
      before_action :ensure_project_member_or_admin
      before_action :set_task, only: [:show, :edit, :update]


  def index
    @tasks = @project.tasks
  end


  def show
    @task = @project.tasks.find(params[:id])
    @comment = Comment.all
    @comment = Comment.new
  end

  def new
    @task = @project.tasks.new
  end

  def create
    @task = @project.tasks.new(task_params)
    if @task.save
      flash[:notice] = "Task was successfully created"
      redirect_to project_tasks_path
    else
      render :new
    end
  end

  def edit
    @task = @project.tasks.find(params[:id])
  end

  def update
    @task = @project.tasks.find(params[:id])
    if @task.update(task_params)
     flash[:notice] = "Task was successfully updated"
     redirect_to project_task_path
    else
      render :edit
    end
  end

  def destroy
    @task = @project.tasks.find(params[:id])
    @task.destroy
    redirect_to project_tasks_path(@project)
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :is_complete, :due_date, :project_id)
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def find_project
    @project = Project.find(params[:project_id])
    end
end
