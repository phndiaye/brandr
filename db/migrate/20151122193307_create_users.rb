class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.string :username, null: false
      t.string :gender, null: true
      t.string :email, null: false

      t.timestamps null: false
    end
  end
end
