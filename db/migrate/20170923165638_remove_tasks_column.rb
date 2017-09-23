class RemoveTasksColumn < ActiveRecord::Migration[5.0]
  def change
    remove_column :quizzes, :tasks
  end
end
