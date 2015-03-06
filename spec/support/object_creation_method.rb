def sign_in
  visit root_path
  click_on 'Sign Up'
  fill_in 'First name', with: 'Annie'
  fill_in 'Last name', with: 'Lydens'
  fill_in 'Email', with: 'annielydens.org'
  fill_in 'Password', with: 'password'
  fill_in 'Password confirmation', with: 'password'
  within ("form") { click_on 'Sign Up' }
end

def create_project
  Project.create!(name: "knit sweater")
end

def create_task(proj)
  Task.create!(description: "buy yarn", due_date: "01/01/2015", project_id: proj.id)
end
