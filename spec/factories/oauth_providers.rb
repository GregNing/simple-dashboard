# frozen_string_literal: true

FactoryBot.define do
  factory :oauth_provider do
    uid { Faker::IDNumber.valid_south_african_id_number }
    name { %w[google facebook].sample }
  end
end
