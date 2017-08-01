class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :password
      t.string :email
      t.string :student_id
      t.string :cookie_digest
      t.boolean :admin, default: false
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
