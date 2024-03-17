FactoryBot.define do
  factory :sprint do
    name { "MyString" }
    start_date { "2024-03-17" }
    end_date { "2024-03-18" }
    active { false }
    project { nil }
  end
end
