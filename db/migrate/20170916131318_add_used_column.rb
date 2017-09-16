class AddUsedColumn < ActiveRecord::Migration[5.0]
  def change
    add_column :tasks, :used, :boolean, default: false
  end
end
