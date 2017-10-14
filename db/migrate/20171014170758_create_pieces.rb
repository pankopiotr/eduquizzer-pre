class CreatePieces < ActiveRecord::Migration[5.0]
  def change
    create_table :pieces do |t|
      t.belongs_to :attempt, index: true
      t.belongs_to :task, index: true
      t.text :randomized_solutions, array: true, default: []
      t.text :chosen_solutions, array: true, default: []

      t.timestamps
    end
  end
end
