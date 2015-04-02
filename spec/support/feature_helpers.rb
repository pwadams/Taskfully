def sign_in_admin
  create_admin
  visit sign_in_path
  fill_in "Email", with: "admin@admin.com"
  fill_in "Password", with: "password"
  within ".form-horizontal" do
    click_on "Sign In"
  end
end

def sign_in_chloe
  user = create_user
  visit sign_in_path
  fill_in "Email", with: user.email
  fill_in "Password", with: "password"
    within(".form-horizontal") do
  click_on "Sign In"
  end
end

# def sign_in
#   user = create_user(email:"test@gmail.com", password: "password")
#   visit sign_in_path
#   fill_in "Email", with: "test@gmail.com"
#   fill_in "Password", with: "password"
#     within(".form-horizontal") do
#   click_on "Sign In"
#   end
# end
