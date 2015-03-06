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
    fill_in "Due date", with: "01/01/2015"

    click_on  "Create Task"

    expect(page).to have_content "buy yarn"
    expect(page).to have_content "01/01/2015"
end

  scenario "show task" do

    visit projects_path
    click_on "knit sweater"
    click_link "1 task"
    click_link "buy yarn"

    expect(page).to have_content("buy yarn")
    expect(page).to have_content("01/01/2015")
  end

  scenario 'User edits tasks' do

    visit projects_path
    click_link 'knit sweater'
    click_link "1 task"
    click_on "Edit"
    fill_in 'Description', with: 'vacuum car'
    click_on 'Update Task'
    expect(page).to have_content('vacuum car')
    expect(page).to have_no_content('wash')
  end

  scenario 'User deletes task' do

      visit projects_path
      click_link 'knit sweater'
      click_link "1 task"
      click_on "Destroy"
    end
end
