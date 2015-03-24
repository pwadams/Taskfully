namespace :cleanup do
  desc 'removes all memberships where their users have been deleted'
  task removes_memberships_users: :environment do
    existing_users_id = User.pluck(:id)
    deleted_users = Membership.where.not(user_id: existing_users_id).destroy_all
    p "#{deleted_users} were removed."
  end

  desc 'removes all memberships for which projects have been deleted'
  task removes_memberships_projects: :environment do
    remove_memberships = Membership.where.not(project_id: Project.pluck(:id)).destroy_all
    p "#{remove_memberships} were removed."
  end

  desc 'removes all tasks whre their projects have been deleted'
  task removes_tasks_projects: :environment do
    remove_tasks = Task.where.not(project_id: Project.pluck(:id)).destroy_all
    p "#{remove_tasks} were removed."
  end

  desc 'removes all comments where their tasks have been deleted'
  task removes_comments_tasks: :environment do
    null_tasks = Comment.where.not(task_id: Task.pluck(:id)).destroy_all
    p "#{null_tasks} were removed."
  end

  desc 'sets the user_id of comments to nil if their users have been deleted'
  task deleted_comment_user: :environment do
    orphaned_comments = Comment.where.not(user_id: User.pluck(:id))
    orphaned_comments.each do |comment|
      comment.update_attributes(user_id: nil)
    end
    p "#{orphaned_comments} were updated with user_id: nil."
  end

  desc 'removes any task with a null project_id'
  task task_null_project: :environment do
    null_tasks = Task.where(project_id: nil).destroy_all
    p "#{null_tasks} were removed."
  end

  desc 'removes any comments with a null task_id'
  task comment_null_task: :environment do
    null_comments = Comment.where(task_id: nil).destroy_all
    p "#{null_comments} were removed."
  end

  desc 'removes any memberships with a null project_id or user_id'
  task membership_null_project_user: :environment do
    null_pid_memberships = Membership.where('project_id = ?', nil).destroy_all
    null_oid_memberships = Membership.where('user_id = ?', nil).destroy_all
    p "#{null_pid_memberships} and #{null_oid_memberships} were removed."
  end
end
