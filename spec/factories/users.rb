# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test-#{n}@gmail.com" }
    name { Faker::Games::WorldOfWarcraft.hero }
    password { "nyhbhZ1B13djVvMoywa-"  }
  end
end
