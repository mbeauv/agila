# spec/factories/projects.rb

FactoryBot.define do
    factory :project do
      name { "My Project" }
      description { "Project Description" }
      status { "not_started" }
      start_date { Date.today }
      # Add other attributes here
    end
  end