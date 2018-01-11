FactoryBot.define do
  pw = RandomData.password
  factory :user do
    username RandomData.username
    sequence(:email){|n| "user#{n}@blocipedia_factory.edu" }
    password pw
    password_confirmation pw
    confirmed_at Time.now.utc
  end
end
