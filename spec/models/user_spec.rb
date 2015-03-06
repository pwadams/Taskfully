
require 'rails_helper'

describe User do

  before :each do
  @user = User.create(first_name: "Joe",
  last_name: "Smith", email: "joe@comcast.com", password: "dingo"
  )
  end

  it "validates the presence of the first name" do
  expect(@user).to be_valid
  end

  it "is invalid without the first name" do
  @user.update_attributes(first_name: nil)
  @user.valid?
  expect(@user.errors[:first_name]).to include("can't be blank")
  end

  it "validates the presence of the last name" do
  expect(@user).to be_valid
  end

  it "is invalid without the last name" do
  @user.update_attributes(last_name: nil)
  @user.valid?
  expect(@user.errors[:last_name]).to include("can't be blank")
  end

  it "validates the uniqueness of the email" do
  user2 = User.create(first_name: "Sue",
  last_name: "Smith", email: "joe@comcast.com"
  )
  user2.valid?
  expect(user2.errors[:email]).to include("has already been taken")
  end
end
