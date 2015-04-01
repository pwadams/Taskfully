require 'rails_helper'

  feature 'Users' do

    before(:each) do
      sign_in_admin
    end

    scenario 'can see projects page' do
      expect(page).to have_content "Projects"
      expect(page).to have_content "You have successfully signed in."
    end

    scenario 'create user' do
      visit users_path
      click_link "New User"

      fill_in :user_first_name, with: "Chloe"
      fill_in :user_last_name, with: "Bradley"
      fill_in :user_email, with: "bradley@gschool.com"
      fill_in "Password", with: "dingo"
      fill_in "Password confirmation", with: "dingo"
      click_button "Create User"

      expect(page).to have_content "User was successfully created"
      expect(page).to have_content "Chloe"
      expect(page).to have_content "Bradley"
      expect(page).to have_content "bradley@gschool.com"
    end

    scenario 'edit user' do
      visit users_path
      click_link 'Edit'
      fill_in :user_first_name, with: "Alexis"
      click_button "Update User"

      expect(page).to have_content "User was successfully updated"
      expect(page).to have_content "Alexis Adams"
    end

    scenario 'delete user' do
      user = create_user
      visit users_path
      click_link user.full_name
      click_link "Edit"
      click_link "Delete User"
      expect(page).to have_no_content user.full_name
    end

    scenario 'can see validation message when first name is not present' do
      visit new_user_path
      fill_in "First name", with: " "
      fill_in "Last name", with: "Bradley"
      fill_in "Email", with: "bradley@gcamp.com"
      fill_in "Password", with: "dingo"
      fill_in "Password confirmation", with: "dingo"
      click_button "Create User"
      expect(page).to have_content "1 error prohibited this form from being saved:
                                    First name can't be blank"
    end
end
