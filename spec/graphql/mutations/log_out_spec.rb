# frozen_string_literal: true

require "rails_helper"

RSpec.describe Mutations::LogOut do
  let(:user) { create(:user) }

  context 'when log out Successful' do
    subject { gql_query(query: mutation, context: { current_user: user }).to_h.deep_symbolize_keys.dig(:data, :logOut) }
    it 'return success' do
      auth_token = user.authentication_token
      user.reload
      subject
      expect(user.authentication_token).to_not eq(auth_token)
      expect(subject[:success]).to eq(true)
      expect(subject[:errors]).to be_blank
    end
  end

  context 'when user not log in' do
    subject { gql_query(query: mutation).to_h.deep_symbolize_keys }

    it 'raise error' do
      subject
      expect(subject.dig(:errors, 0, :message)).to eq('User not signed in')
      expect(subject.dig(:data, :logIn)).to be_blank
    end
  end

  def mutation
    <<~GQL
      mutation logOut {
        logOut(input: {}) {
          success
          errors
        }
      }
    GQL
  end
end
