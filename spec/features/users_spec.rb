require 'rails_helper'

  feature 'Users' do
    before do
      sign_in
      @user = User.new(first_name: "Chloe", last_name: "Bradley", email: "bradley@gschool.com", password: "dingo", password_confirmation: "dingo")
      @user.save!
    end

    scenario 'can see welcome page' do
      visit sign_in_path
      expect(page).to have_content "Users"
      expect(page).to have_content "Chloe"
      expect(page).to have_content "Bradley"
      expect(page).to have_content "bradley@gschool.com"
    end

    scenario 'create user' do
      visit users_path
      click_link "New User"

      fill_in :user_first_name, with: "Chloe"
      fill_in :user_last_name, with: "Bradley"
      fill_in :user_email, with: "wadams@email.com"
      fill_in "Password", with: "dingo"
      fill_in "Password confirmation", with: "dingo"
      click_button "Create User"

      expect(page).to have_content "User was successfully created"
      expect(page).to have_content "Chloe"
      expect(page).to have_content "Bradley"
      expect(page).to have_content "bradley@gschool.com"
    end

    scenario 'edit user' do
      visit user_path(@user)
      click_on "Edit"
      fill_in :user_first_name, with: "Alexis"
      click_button "Update User"

      expect(page).to have_content "User was successfully updated"
      expect(page).to have_content "Alexis Bradley"
    end

    scenario 'delete user' do
      visit users_path

      click_link "Chloe Bradley"
      click_link "Edit"
      click_link "Delete User"
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
