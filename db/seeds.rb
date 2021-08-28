# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create!(user_name: "firstlast", first_name: "first", last_name: "last", email: "example@example.com", birthday: "12-12-1990", phone_number: "123")
user2 = User.create!(user_name: "username", first_name: "Zach", last_name: "Trokey", email: "email@email.com", birthday: "12-12-1990", phone_number: "456")
post = user.posts.create(content: "This is my post!")
post2 = user2.posts.create(content: "This is another post!")
