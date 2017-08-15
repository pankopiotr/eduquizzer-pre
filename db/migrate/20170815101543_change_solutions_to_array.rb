class ChangeSolutionsToArray < ActiveRecord::Migration[5.0]
  def change
    change_column :tasks, :correct_solutions, :text, array: true, default: [], using: "(string_to_array(correct_solutions, ','))"
    change_column :tasks, :wrong_solutions, :text, array: true, default: [], using: "(string_to_array(wrong_solutions, ','))"
  end
end
