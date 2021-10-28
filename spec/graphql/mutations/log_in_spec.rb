# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::LogIn do
  let!(:user) { create(:user) }

  context 'when login Successful' do
    let(:variables) do
      {
        email: user.email,
        password: user.password
      }
    end
    subject { gql_query(query: mutation, variables: variables).to_h.deep_symbolize_keys.dig(:data, :logIn) }

    it 'return user' do
      user.reload
      expect(subject.dig(:user, :id)).to eq(user.gql_id)
      expect(subject.dig(:user, :authenticationToken)).to eq(user.authentication_token)
      expect(subject[:success]).to eq(true)
      expect(subject[:errors]).to be_blank
    end
  end

  context 'when login has incorrect email/password' do
    let(:variables) do
      {
        email: user.email,
        password: "#{Devise.friendly_token[0..20]}@"
      }
    end
    subject { gql_query(query: mutation, variables: variables).to_h.deep_symbolize_keys }

    it 'raises error' do
      expect(subject.dig(:errors, 0, :message)).to eq('Incorrect Email/Password')
      expect(subject.dig(:data, :logIn)).to be_blank
    end
  end

  context 'when use not exists' do
    let(:variables) do
      {
        email: Faker::Internet.email,
        password: "#{Devise.friendly_token[0..20]}@"
      }
    end
    subject { gql_query(query: mutation, variables: variables).to_h.deep_symbolize_keys }

    it 'raises error for missing user' do
      expect(subject.dig(:errors, 0, :message)).to eq('User not registered on this application')
      expect(subject.dig(:data, :logIn)).to be_blank
    end
  end

  def mutation
    <<~GQL
      mutation logIn($email: String!, $password: String!) {
        logIn(input: { email: $email, password: $password }) {
          user {
            id
            name
            authenticationToken
          }
          success
          errors
        }
      }
    GQL
  end
end
