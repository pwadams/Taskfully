class CommentsController <PublicController
  before_action :find_and_set_task

  def new
    @comment = @task.comments.new
  end

  def create
    @comment = @task.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to project_task_path(@task.project_id, @task)
    else
      redirect_to project_task_path(@task.project_id, @task)
    end
  end


  private

  def find_and_set_task
    @task = Task.find(params[:task_id])
  end

  def comment_params
    params.require(:comment).permit(:user_id, :task_id, :description)
  end
end
