class AddPiecesToAttempt < ActiveRecord::Migration[5.0]
  def change
    add_column :attempts, :piece_id, :integer
  end
end
