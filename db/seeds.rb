# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u = User.create(email: "rodrigo@example.com", password: "rodrigo123", password_confirmation: "rodrigo123", name: "Rodrigo Amorim")

20.times do |n|
  Contact.create(name: "Nome #{n} Sobrenome", email: "email#{n}example.com.br", user: u)
end