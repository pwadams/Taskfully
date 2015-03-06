require 'rails_helper'

feature 'Managing Tasks' do

  before do
    sign_in
    project = create_project
    task = create_task(project)
  end

  scenario 'create task' do
    visit projects_path
    click_on "knit sweater"
    click_link "1 task"
    click_on "New Task"
    fill_in "Description", with: "buy yarn"
    fill_in "Due date", with: "19/04/2015"

    click_on  "Create Task"

    expect(page).to have_content "buy yarn"
    expect(page).to have_content "04/19/2015"
end

  scenario "show task" do
    visit tasks_path
    click_link "wash"
    expect(page).to have_content("wash")
    expect(page).to have_content("04/15/2015")
  end

  scenario 'User edits tasks' do

    visit tasks_path
    expect(page).to have_content("wash")
    click_on 'Edit'
    fill_in 'Description', with: 'vacuum car'
    click_on 'Update Task'
    expect(page).to have_content('vacuum car')
    expect(page).to have_no_content('wash')
  end

  scenario 'User deletes task' do

      visit tasks_path
      click_on "Destroy"
    end
end
