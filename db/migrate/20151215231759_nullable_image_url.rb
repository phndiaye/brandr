class NullableImageUrl < ActiveRecord::Migration
  def change
    change_column_null :hunts, :image_url, true
  end
end
