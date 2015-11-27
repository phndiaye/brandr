class AddHuntItemsTable < ActiveRecord::Migration
  def change
    create_table :hunt_items do |t|
      t.integer :top
      t.integer :left
      t.belongs_to :hunt

      t.timestamps null: false
    end
  end
end
