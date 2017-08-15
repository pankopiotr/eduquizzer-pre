class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :type
      t.string :category
      t.text :description
      t.text :asset
      t.text :correct_solutions
      t.text :wrong_solutions
      t.integer :score
      t.boolean :deleted
      t.boolean :mathjax
      t.boolean :random
      t.integer :no_solutions
      t.integer :min_no_correct_solutions

      t.timestamps
    end
  end
end
