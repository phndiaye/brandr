class HuntItem < ActiveRecord::Base
  belongs_to :hunt
  has_many :hunt_comments

  validates_presence_of :top, :left

  def comments_count
    hunt_comments.count || 0
  end
end
