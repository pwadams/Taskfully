class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
      @task = Task.new(task_params)
      task.save


      redirect_to root_path
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Tasks.find(params[:id])
    if @task.update(task_params)
      redirect_to tasks_path
    else
      render :edit
  end
end

def destroy
    task = Task.find(params[:id])
    task.delete

  redirect_to tasks_path
end

  private

  def task_params
    params.require(:task).permit(:name, :description,)
  end
end
