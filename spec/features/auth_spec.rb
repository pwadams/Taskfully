require 'rails_helper'


feature 'Authentication' do
  before do
    @user = User.create(first_name: "Ian", last_name: "Brennen", email: 'ian@gschool.com', password: 'iamsosmart', password_confirmation: "iamsosmart")
  end

  scenario 'Users can sign up and they are automatically logged in' do
    visit root_path
    click_on 'Sign Up'
    fill_in 'First name', with: 'Annie'
    fill_in 'Last name', with: 'Lydens'
    fill_in 'Email', with: 'annielydens.org'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
	  within ("form") { click_on 'Sign Up' }
    expect(page).to have_content('Annie Lydens')
    expect(page).to have_content('You have successfully signed up.')
    expect(page).not_to have_content('Sign Up')
    expect(page).not_to have_content('Sign In')
  end

  scenario 'Users cannot sign up' do
    visit root_path
    click_on 'Sign Up'
    fill_in 'First name', with: ''
    fill_in 'Last name', with: 'Lydens'
    fill_in 'Email', with: 'annielydens.org'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
	  within ("form") { click_on 'Sign Up' }
    expect(page).to have_content("can't be blank")
  end

  scenario 'User can log in' do
    visit root_path
    click_on 'Sign In'
    fill_in 'Email', with: 'ian@gschool.com'
    fill_in 'Password', with: 'iamsosmart'
    within ("form") { click_on 'Sign In' }
    expect(page).to have_content('Ian Brennen')
    expect(page).to have_content('You have successfully signed in.')
    expect(page).not_to have_content('Sign Up')
    expect(page).not_to have_content('Sign In')
  end

  scenario 'User cannot log in' do
    visit root_path
    click_on 'Sign In'
    fill_in 'Email', with: 'ian@gschool.com'
    fill_in 'Password', with: 'isosmart'
    within ("form") { click_on 'Sign In' }
    expect(page).not_to have_content('Ian Brennen')
    expect(page).to have_content('Email/Password combination is invalid.')
    expect(page).to have_content('Sign Up')
    expect(page).to have_content('Sign In')
  end

  scenario 'User can log out' do
    visit root_path
    click_on 'Sign In'
    fill_in 'Email', with: 'ian@gschool.com'
    fill_in 'Password', with: 'iamsosmart'
    within ("form") { click_on 'Sign In' }
    click_on 'Sign Out'
    expect(page).not_to have_content('Ian Brennen')
    expect(page).to have_content('Sign Up')
    expect(page).to have_content('Sign In')
  end
end
