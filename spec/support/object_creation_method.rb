def create_admin
  User.create!(
  first_name: 'Pamela',
  last_name: 'Adams',
  email: "admin@admin.com",
  password: "password",
  password_confirmation: "password",
  admin: true)
end

def create_user(options = {})
  User.create!({
    first_name: 'Chloe',
    last_name: 'Bradley',
    email: "bradley#{rand(1000)+1}@gschool.com",
    password: 'password',
    password_confirmation: "password",
    admin: false
  }.merge(options))
end

def create_member(project, user, options = {})
  Membership.create!({
    role: 'member',
    user_id: user.id,
    project_id: project.id
  }.merge(options))
end

def create_project(options = {})
  Project.create!({
    name: "knit sweater"
  }.merge(options))
end

def create_task(options = {})
  Task.create!({
    description: "buy yarn",
    due_date: "01/01/2015",
    project_id: create_project.id
  }.merge(options))
end

def destroy_records
  User.destroy_all
  Membership.destroy_all
  Project.destroy_all
end
