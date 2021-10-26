# frozen_string_literal: true

require "rails_helper"

RSpec.describe Mutations::RegisterUser do
  it "registers the user" do
    variables = {
      "name" => "James",
      "email" => "kleinjm007@gmail.com",
      "password" => "testing123"
    }

    result = gql_query(query: mutation, variables: variables).
      to_h.deep_symbolize_keys.dig(:data, :registerUser)

    expect(result[:errors]).to be_blank
  end

  it "raises error for RecordInvalid" do
    variables = {
      "name" => "James",
      "email" => "kleinjm007@gmail.com",
      "password" => "testing123"
    }

    user = User.new
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
