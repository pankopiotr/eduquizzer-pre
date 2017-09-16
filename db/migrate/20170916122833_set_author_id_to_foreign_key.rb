class SetAuthorIdToForeignKey < ActiveRecord::Migration[5.0]
  def change
    add_reference :tasks, :author, references: :users, index: true
    add_foreign_key :tasks, :users, column: :author_id
  end
end
