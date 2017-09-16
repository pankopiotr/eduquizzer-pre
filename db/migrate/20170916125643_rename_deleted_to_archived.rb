class RenameDeletedToArchived < ActiveRecord::Migration[5.0]
  def change
    rename_column :tasks, :deleted, :archived
  end
end
