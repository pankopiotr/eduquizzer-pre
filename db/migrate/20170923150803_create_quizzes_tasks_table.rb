class CreateQuizzesTasksTable < ActiveRecord::Migration[5.0]
  def change
    create_table :quizzes_tasks, id: false do |t|
      t.belongs_to :quiz, index: true
      t.belongs_to :task, index: true
    end
  end
end