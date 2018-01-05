require 'random_data'

10.times do
  pw = RandomData.password
  User.create!(
    username: RandomData.username,
    email: RandomData.email,
    password: pw,
    password_confirmation: pw,
    confirmed_at: Time.now.utc # skip confirmation
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

33.times do
  Wiki.create!(
    title: RandomData.title,
    body: RandomData.paragraph,
    private: false,
    user: users.sample
  )
end

puts "#{User.count} users created"
puts "#{Wiki.count} (public) wikis created"
