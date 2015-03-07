class RemoveNameFromTasks < ActiveRecord::Migration
  def change
    remove_column :tasks, :name, :string
  end
end
