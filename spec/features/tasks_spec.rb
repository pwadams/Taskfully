require 'rails_helper'

feature 'Managing Tasks' do

  before do
    sign_in_chloe
    project = create_project
    task = create_task
  end

  scenario 'create task' do
    visit projects_path
    within 'nav' do
      click_link "New Project"
    end
    fill_in "Name", with: "Household chores"
    click_button "Create Project"
    click_on "New Task"
    fill_in "Description", with: "buy yarn"
    fill_in "Due date", with: "01/01/2015"

    click_on  "Create Task"

    expect(page).to have_content "buy yarn"
    expect(page).to have_content "01/01/2015"
  end

  scenario "show task" do
    visit projects_path
    within 'nav' do
      click_link "New Project"
    end
    fill_in "Name", with: "knit sweater"
    click_button "Create Project"
    within 'nav' do
      click_link "knit sweater"
    end
    click_link "0 Tasks"
  end

  scenario 'User edits and deletes task' do
    visit projects_path
    within 'nav' do
      click_link "New Project"
    end

    fill_in "Name", with: "knit sweater"
    click_button "Create Project"

    click_link 'New Task'
    fill_in 'Description', with: 'vacuum car'
    click_on 'Create Task'
    expect(page).to have_content('vacuum car')
    expect(page).to have_no_content('wash')
    click_on "Edit"
    fill_in "Description", with: "buy yarn"
    fill_in "Due date", with: "01/01/2015"

    click_on  "Update Task"
    click_on "Tasks"
    expect(page).to have_content "buy yarn"
    expect(page).to have_content "01/01/2015"
    find('.glyphicon-remove').click
  end
end
