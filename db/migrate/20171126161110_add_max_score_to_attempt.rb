class AddMaxScoreToAttempt < ActiveRecord::Migration[5.0]
  def change
    add_column :attempts, :max_score, :integer
  end
end
