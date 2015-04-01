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
  create_user
  visit sign_in_path
  fill_in "Email", with: "bradley@gschool.com"
  fill_in "Password", with: "password"
    within(".form-horizontal") do
  click_on "Sign In"
  end
end
