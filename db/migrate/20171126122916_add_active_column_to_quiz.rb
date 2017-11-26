class AddActiveColumnToQuiz < ActiveRecord::Migration[5.0]
  def change
    add_column :quizzes, :active, :boolean, default: false
  end
end