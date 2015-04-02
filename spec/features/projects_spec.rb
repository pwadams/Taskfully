require 'rails_helper'

feature 'Managing Projects' do

  describe 'Existing User' do

    before :each do
      project = create_project
      sign_in_chloe
    end

    scenario 'create project' do
      visit projects_path

      within 'nav' do
        click_link "New Project"
      end

      fill_in "Name", with: "Household chores"
      click_button "Create Project"
      expect(page).to have_content "Household chores"
      expect(page).to have_content "Project was successfully created"
    end


    scenario "show & edit & delete projects" do
      visit projects_path
      within 'nav' do
        click_link "New Project"
      end
      fill_in "Name", with: "Household chores"
      click_button "Create Project"
      expect(page).to have_content "Household chores"
      expect(page).to have_content "Project was successfully created"

      within 'nav' do
        click_link "Household chores"
      end

      expect(page).to have_content("Household chores")

      click_on 'Edit'
      fill_in 'Name', with: "Zoe's chores"
      click_on 'Update Project'
      expect(page).to have_content("Zoe's chores")
      expect(page).to have_no_content('Household chores')
      click_on "Delete"
      expect(page).to have_content "Project was successfully deleted"
    end
  end
end
