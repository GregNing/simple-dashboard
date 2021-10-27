# frozen_string_literal: true

require "rails_helper"

RSpec.describe Mutations::RegisterUser do
  let(:variables) {{
      name: Faker::Games::WorldOfWarcraft.hero,
      email: Faker::Internet.email,
      password: "#{Devise.friendly_token[0..20]}@"
   }}

  it "registers the user" do
    result = gql_query(query: mutation, variables: variables).
      to_h.deep_symbolize_keys.dig(:data, :registerUser)

    expect(result[:errors]).to be_blank
  end

  it "raises error for RecordInvalid" do
    user = User.new()
    user.validate # missing fields makes this invalid
    allow(User).to receive(:create!).
      and_raise(ActiveRecord::RecordInvalid.new(user))
    result = gql_query(query: mutation, variables: variables).
      to_h.deep_symbolize_keys

    expect(result[:errors]).to_not be_blank
    expect(result.dig(:errors, 0, :message)).
      to include(user.errors.full_messages.first)
  end

  def mutation
    <<~GQL
      mutation registerUser(
        $name: String!,
        $email: String!,
        $password: String!,
      ) {
        registerUser(input: {
          name: $name,
          email: $email,
          password: $password,
        }) {
          success
          errors
        }
      }
    GQL
  end
end
