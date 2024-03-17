FactoryBot.define do
  factory :user_story do
    title { "MyString" }
    description { "MyText" }
    estimate { 1 }
    project { nil }
  end
end
