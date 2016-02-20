class HuntItemSerializer < ActiveModel::Serializer
  attributes :id, :top, :left, :created_at, :updated_at

  has_many :hunt_comments
end
