# frozen_string_literal: true

require "rails_helper"

RSpec.describe Mutations::UpdatePasswordWithToken, type: :request do
  let(:user) { FactoryBot.create(:user_expired_unconfirmed_password) }
  let(:reset_password_token) { user.send_reset_password_instructions }
  let(:old_passw) { user.encrypted_password }
  let(:new_passw) { '#_3x4zWjKxovR8phmLwLP@asdasdASDASDASDadasdas' }
  let(:variables) {{
    'reset_password_token' => reset_password_token,
    'password' => new_passw,
    'passwordConfirmation' => new_passw
  }}
  let(:mutation) {
    <<~GQL
      mutation updatePasswordWithToken($reset_password_token: String!, $password: String!, $passwordConfirmation: String!) {
        updatePasswordWithToken(input: {
          resetPasswordToken: $reset_password_token,
          password: $password,
          passwordConfirmation: $passwordConfirmation }) {
            success
            errors
        }
      }
    GQL
  }

  context 'reset password with token' do
    subject { gql_query(query: mutation, variables: variables) }

    it '.email_reset_instructions' do
      expect(user.encrypted_password).to eq old_passw
      subject
      user.reload
      expect(user.encrypted_password).not_to eq old_passw
    end
  end
end
