class Hunt < ActiveRecord::Base
  belongs_to :user
  has_many :hunt_items

  def hunts_count
    hunt_items.count
  end
end
