class HuntItem < ActiveRecord::Base
  belongs_to :hunt
  has_many :hunt_comments

  def comments_count
    hunt_comments.count
  end
end
