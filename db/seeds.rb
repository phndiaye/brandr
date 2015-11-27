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
jeannecarr = User.first_or_create(
  firstname: 'Jeanne', lastname: 'Carr', username: 'jcarr',
  email: 'jeanne.carr86@example.com', password: 'password123',
  password_confirmation: 'password123')

hunt_1 = Hunt.create(user: iamphinson, image_url: 'http://photon.101medialablimit.netdna-cdn.com/hypebeast.com/image/2015/10/essentials-maxime-buchi-1.jpg')
Hunt.create(user: iamphinson, image_url: 'http://photon.101medialablimit.netdna-cdn.com/hypebeast.com/image/2015/09/essentials-matt-fine-of-shiekh-shoes-001.jpg?w=1382')
Hunt.create(user: iamphinson, image_url: 'http://photon.101medialablimit.netdna-cdn.com/hypebeast.com/image/2015/09/essentials-astrid-andersen-1.jpg?w=1382')
Hunt.create(user: iamphinson, image_url: 'https://s-media-cache-ak0.pinimg.com/736x/e3/06/d1/e306d1537eb21119449172c2a08915d1.jpg')
Hunt.create(user: iamphinson, image_url: 'http://photon.101medialablimit.netdna-cdn.com/hypebeast.com/image/2015/08/essentials-jason-peterson-01.jpg?w=1499')
Hunt.create(user: iamphinson, image_url: 'http://photon.101medialablimit.netdna-cdn.com/hypebeast.com/image/2015/10/essentials-maxime-buchi-1.jpg?w=1382')

hunt_item_1 = HuntItem.create(hunt: hunt_1, top: 50, left: 38)
hunt_item_2 = HuntItem.create(hunt: hunt_1, top: 10, left: 50)
HuntItem.create(hunt: hunt_1, top: 75, left: 90)

HuntComment.create(user: jeannecarr, hunt_item: hunt_item_1, text: 'Entitled "Juke Or Treat,\" the track was shared by The Social')
HuntComment.create(user: jeannecarr, hunt_item: hunt_item_2, text: 'Entitled "Juke Or Treat," the track was shared by The Socia')
