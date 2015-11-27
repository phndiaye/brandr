class AddHuntsTable < ActiveRecord::Migration
  def change
    create_table :hunts do |t|
      t.string :image_url, null: false
      t.belongs_to :user

      t.timestamps null: false
    end
  end
end
