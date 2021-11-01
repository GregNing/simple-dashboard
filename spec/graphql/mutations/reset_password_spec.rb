# frozen_string_literal: true

require "rails_helper"

RSpec.describe Mutations::ResetPassword, type: :request do
  let(:user) { FactoryBot.create(:user_expired_unconfirmed_password) }
  let(:reset_password_token) { user.send_reset_password_instructions }
  let(:old_passw) { user.password }
  let(:new_passw) { '#_3x4zWjKxovR8phmLwLP@asdasdASDASDASDadasdas' }
  let(:variables) {{
    'oldpassword' => old_passw,
    'password' => new_passw,
    'passwordConfirmation' => new_passw
  }}
  let(:mutation) {
    <<~GQL
      mutation resetPassword($oldpassword: String!, $password: String!, $passwordConfirmation: String!) {
        resetPassword(input: {
          oldpassword: $oldpassword,
          password: $password,
          passwordConfirmation: $passwordConfirmation }) {
            success
            errors
        }
      }
    GQL
  }

  context 'reset password with old password' do
    subject { gql_query(query: mutation, variables: variables, context: { current_user: user }) }

    it do
      subject
      user.reload
      expect(user.encrypted_password).not_to eq old_passw
    end
  end
end
