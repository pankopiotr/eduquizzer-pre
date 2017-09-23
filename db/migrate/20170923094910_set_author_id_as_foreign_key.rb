class SetAuthorIdAsForeignKey < ActiveRecord::Migration[5.0]
  def change
    add_reference :quizzes, :author, references: :users, index: true
    add_foreign_key :quizzes, :users, column: :author_id
  end
end
