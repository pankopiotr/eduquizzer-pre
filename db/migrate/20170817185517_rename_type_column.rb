class RenameTypeColumn < ActiveRecord::Migration[5.0]
  def change
    rename_column :tasks, :type, :task_type
  end
end
