namespace :cleanup do
  desc 'removes all memberships where their users have been deleted'
  task memberships_users: :environment do
    existing_users_id = User.pluck(:id)
    Membership.where.not(user_id: existing_users_id).destroy_all
    p "memberships_users were removed."
  end

  desc 'removes all memberships for which projects have been deleted'
  task memberships_projects: :environment do
    Membership.where.not(project_id: Project.pluck(:id)).destroy_all
    p "memberships_projects were removed."
  end

  desc 'removes all tasks where their projects have been deleted'
  task tasks_projects: :environment do
    Task.where.not(project_id: Project.pluck(:id)).destroy_all
    p "tasks_projects were removed."
  end

  desc 'Removes all comments where their tasks have been deleted'
  task comments: :environment do
    Comment.where.not(task_id: Task.all)
    destroy_orphans(comment_orphans, "comments table")
    p "comment_orphans were removed"
  end

  desc 'sets the user_id of comments to nil if their users have been deleted'
  task deleted_comment_user: :environment do
    Comment.where.not(user_id: User.pluck(:id))
    orphaned_comments.each do |comment|
      comment.update_attributes(user_id: nil)
    end
    p "orphaned_comments were updated with user_id: nil."
  end

  desc 'removes any task with a null project_id'
  task task_null_project: :environment do
    Task.where(project_id: nil).destroy_all
    p "task_null_project were removed."
  end

  desc 'removes any comments with a null task_id'
  task comment_null_task: :environment do
    Comment.where(task_id: nil).destroy_all
    p "comment_null_task were removed."
  end

  desc "Deletes any memberships with a null project_id"
  task memberships_null_project: :environment do
    Membership.where(project_id: nil).destroy_all
    p "memberships_null_project were removed."
  end

  desc "Deletes any project with null memberships"
  task projects_null_memberships: :environment do
    projects = Project.all
      projects.each do |project|
      if project.memberships.count == 0
        project.destroy
    p "projects_null_memberships were removed."
      end
    end
  end
end
