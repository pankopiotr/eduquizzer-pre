class CreateAttempts < ActiveRecord::Migration[5.0]
  def change
    create_table :attempts do |t|
      t.belongs_to :user, index: true
      t.belongs_to :quiz, index: true
      t.integer :score
      t.timestamps
    end
  end
end
