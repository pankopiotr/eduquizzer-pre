class AddArchivedToQuiz < ActiveRecord::Migration[5.0]
  def change
    add_column :quizzes, :archived, :boolean, default: false
    add_column :quizzes, :archived_at, :datetime
  end
end
