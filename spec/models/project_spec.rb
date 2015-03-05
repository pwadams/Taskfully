require 'rails_helper'

describe Project do

  it "validates the presence of the name" do
  project = Project.new(name: "paint house")
  expect(project).to be_valid
  end

  it "is invalid without the name" do
  project = Project.new(name: nil)
  project.valid?
  expect(project.errors[:name]).to include("can't be blank")
  end
end
