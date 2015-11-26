class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :firstname, :lastname, :gender, :username,
             :created_at, :updated_at
end
