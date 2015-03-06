require 'rails_helper'

feature 'Managing Tasks' do

  before do
    sign_in
    task = Task.new(description: "wash", due_date: "15/04/2015")
    task.save!
  end

  scenario 'create task' do
    visit tasks_path
    click_on "New Task"

    fill_in "Description", with: "wash"
    fill_in "Due date", with: "15/04/2015"

    click_on  "Create Task"

    expect(page).to have_content "wash"
    expect(page).to have_content "04/15/2015"
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
