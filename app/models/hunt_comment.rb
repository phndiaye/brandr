class HuntComment < ActiveRecord::Base
  belongs_to :user
  belongs_to :hunt_item
end
