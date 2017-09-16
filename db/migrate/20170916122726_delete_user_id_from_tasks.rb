class DeleteUserIdFromTasks < ActiveRecord::Migration[5.0]
  def change
    remove_column :tasks, :user_id
  end
end
