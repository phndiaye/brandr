class Hunt < ActiveRecord::Base
  mount_uploader :image, HuntImageUploader

  belongs_to :user
  has_many :hunt_items

  validates :image, presence: true

  def hunts_count
    hunt_items.count
  end
end
