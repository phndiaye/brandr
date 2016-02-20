class HuntItem < ActiveRecord::Base
  belongs_to :hunt
  has_many :hunt_comments

  validates_presence_of :top, :left
end
