class SetUsedDefault < ActiveRecord::Migration[5.0]
  def change
    change_column_default :quizzes, :used, false
  end
end
