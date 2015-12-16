class AddImageToHunt < ActiveRecord::Migration
  def change
    add_column :hunts, :image, :string
  end
end
