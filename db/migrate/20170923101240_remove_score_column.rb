class RemoveScoreColumn < ActiveRecord::Migration[5.0]
  def change
    remove_column :quizzes, :score
  end
end
