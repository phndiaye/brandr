class HuntSerializer < ActiveModel::Serializer
  embed :ids, include: true

  attributes :id, :image_url, :user, :hunts_count, :created_at, :updated_at

  has_many :hunt_items
end
