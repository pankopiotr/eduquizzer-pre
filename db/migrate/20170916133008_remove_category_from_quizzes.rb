class RemoveCategoryFromQuizzes < ActiveRecord::Migration[5.0]
  def change
    remove_column :quizzes, :category
  end
end
