require 'faker'

10.times do
  pw = Faker::Internet.password(8)
  User.create!(
    username: Faker::Ancient.unique.titan,
    email: Faker::Internet.unique.email,
    password: pw,
    password_confirmation: pw,
    confirmed_at: Time.now.utc
  )
end

member = User.create!(
  username: 'Member User',
  email: 'member@example.com',
  password: 'helloworld',
  password_confirmation: 'helloworld',
  confirmed_at: Time.now.utc
)
users = User.all

6.times do
  Wiki.create!(
    title: Faker::Beer.unique.style,
    body: Faker::Hipster.paragraph,
    private: false,
    user: users.sample
  )
end

puts "#{User.count} users created"
puts "#{Wiki.count} (public) wikis created"
