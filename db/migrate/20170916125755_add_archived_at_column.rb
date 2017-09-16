class AddArchivedAtColumn < ActiveRecord::Migration[5.0]
  def change
    add_column :tasks, :archived_at, :datetime
  end
end
