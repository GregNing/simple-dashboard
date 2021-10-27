# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test-#{n}@gmail.com" }
    name { Faker::Games::WorldOfWarcraft.hero }
    password { "#{Devise.friendly_token[0..20]}@"  }
  end
end
