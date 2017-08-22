class ChangeAssetColumnToString < ActiveRecord::Migration[5.0]
  def change
    change_column :tasks, :asset, :string
  end
end