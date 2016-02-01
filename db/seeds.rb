# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
iamphinson = User.where(email: 'phndiaye@gmail.com').first_or_create(
  firstname: 'Philippe', lastname: 'Ndiaye', username: 'iamphinson',
  email: 'phndiaye@gmail.com', password: 'philippe123',
  password_confirmation: 'philippe123')
jeannecarr = User.where(email: 'jeanne.carr86@example.com').first_or_create(
  firstname: 'Jeanne', lastname: 'Carr', username: 'jcarr',
  email: 'jeanne.carr86@example.com', password: 'password123',
  password_confirmation: 'password123')

[1, 2, 3, 4, 5].each do |img|
  hunt = Hunt.new(user: iamphinson)
  File.open("#{Rails.root}/db/seed-images/#{img}.jpg") do |f|
    hunt.image = f
  end
  hunt.hunt_items << HuntItem.create(hunt: hunt, top: 50, left: 38)
  hunt.hunt_items << HuntItem.create(hunt: hunt, top: 10, left: 50)
  hunt.hunt_items << HuntItem.create(hunt: hunt, top: 75, left: 90)
  hunt.save!
end


HuntComment.create(user: jeannecarr, hunt_item: HuntItem.first, text: 'Entitled "Juke Or Treat,\" the track was shared by The Social')
HuntComment.create(user: jeannecarr, hunt_item: HuntItem.last, text: 'Entitled "Juke Or Treat," the track was shared by The Socia')
