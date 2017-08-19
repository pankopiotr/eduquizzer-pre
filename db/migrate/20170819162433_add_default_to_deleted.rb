class AddDefaultToDeleted < ActiveRecord::Migration[5.0]
  def change
    change_column_default :tasks, :deleted, false
  end
end
