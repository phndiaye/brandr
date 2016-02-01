class User < ActiveRecord::Base
  has_secure_password

  has_many :hunts

  validates_presence_of :firstname, :lastname, :username, :email, :password
  validates :email, :username, uniqueness: true
  #validates_uniqueness_of :email, :username
end
