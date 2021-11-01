# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test-#{n}@gmail.com" }
    name { Faker::Games::WorldOfWarcraft.hero }
    password { "nyhbhZ1B13djVvMoywa-"  }
    after(:build)   { |user| user.skip_confirmation_notification! }
    after(:create) { |user| user.confirm }
  end

  factory :user_expired_unconfirmed_password, parent: :user do
    email { Faker::Internet.email }
    confirmed_at { 2.days.ago }
    reset_password_token { nil }
    reset_password_sent_at { nil }
    updated_at { 2.hours.ago }
  end
end
