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
