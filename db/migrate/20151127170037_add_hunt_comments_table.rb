class AddHuntCommentsTable < ActiveRecord::Migration
  def change
    create_table :hunt_comments do |t|
      t.belongs_to :user
      t.belongs_to :hunt_item
      t.text :text

      t.timestamps null: false
    end
  end
end
