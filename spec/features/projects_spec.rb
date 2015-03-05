require 'rails_helper'

feature 'Managing Projects' do

  before do
    project = Project.new(name: "Household chores")
    project.save!
  end

  scenario 'create project' do
    visit projects_path
    click_link "New Project"
    fill_in "Name", with: "Household chores"
    click_button "Create Project"
    expect(page).to have_content "Household chores"
    expect(page).to have_content "Project was successfully created"
end

  scenario "show projects" do
    visit projects_path
    click_link "Household chores"
    expect(page).to have_content("Household chores")
  end

  scenario 'edit project' do

    visit projects_path
    expect(page).to have_content("Household chores")
    click_link "Household chores"
    click_on 'Edit'
    fill_in 'Name', with: "Zoe's chores"
    click_on 'Update Project'
    expect(page).to have_content("Zoe's chores")
    expect(page).to have_no_content('Household chores')
  end

  scenario 'delete project' do

      visit projects_path
      click_link "Household chores"
      click_on "Destroy"
    end
end
