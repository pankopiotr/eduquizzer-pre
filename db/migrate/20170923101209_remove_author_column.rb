class RemoveAuthorColumn < ActiveRecord::Migration[5.0]
  def change
    remove_column :quizzes, :author
  end
end
