require 'rails_helper'

  describe Task do

    it "validates the presence of the description" do
    task = Task.new(description: "buy paint")
    expect(task).to be_valid
    end

    it "is invalid without the description" do
    task = Task.new(description: nil)
    task.valid?
    expect(task.errors[:description]).to include("can't be blank")
    end
  end
