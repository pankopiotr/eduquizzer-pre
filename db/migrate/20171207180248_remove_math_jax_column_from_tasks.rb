class RemoveMathJaxColumnFromTasks < ActiveRecord::Migration[5.0]
  def change
    remove_column :tasks, :mathjax
  end
end
