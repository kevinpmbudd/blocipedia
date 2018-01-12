FactoryBot.define do
  factory :wiki do
    title RandomData.title
    body RandomData.paragraph
    private false 
    user
  end
end
