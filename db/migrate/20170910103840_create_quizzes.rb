class CreateQuizzes < ActiveRecord::Migration[5.0]
  def change
    create_table :quizzes do |t|
      t.string :name
      t.string :password
      t.string :tasks, array: true, default: []
      t.boolean :random
      t.integer :no_random_tasks
      t.boolean :used
      t.integer :time_limit
      t.integer :score
      t.string :author
      t.string :category

      t.timestamps
    end
  end
end
