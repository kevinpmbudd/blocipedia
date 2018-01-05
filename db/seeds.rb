# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'random_data'

10.times do
  User.create!(
    username: RandomData.username,
    email: RandomData.email,
    password: RandomData.password
  )
end

member = User.create!(
  username: 'Member User',
  email: 'member@example.com',
  password: 'helloworld'
)

puts "#{User.count} users created"
