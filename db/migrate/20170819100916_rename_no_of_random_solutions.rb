class RenameNoOfRandomSolutions < ActiveRecord::Migration[5.0]
  def change
    rename_column :tasks, :no_solutions, :no_random_solutions
    rename_column :tasks, :min_no_correct_solutions, :min_no_random_correct_solutions
  end
end
