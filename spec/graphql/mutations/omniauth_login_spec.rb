# frozen_string_literal: true

require "rails_helper"

RSpec.describe Mutations::OmniauthLogin do

  let(:mutation) {
    <<~GQL
      mutation omniauthLogin(
        $provider: String!,
        $uid: String!,
        $name: String!,
        $email: String!,
        $accessToken: String!,
      ) {
        omniauthLogin(input:
          {
            omniauthAttributes: {
              provider: $provider
              uid: $uid
              name: $name
              email: $email
              accessToken: $accessToken
            }
          }
        ) {
          user {
            id
            name
            email
            authenticationToken
          }
          success
          errors
        }
      }
    GQL
  }
  let(:oauth) { Faker::Omniauth.google }
  let(:provider) { OauthProvider::PROVIDER_NAME.sample }
  let(:variables) {{
    'provider' => provider,
    'uid' => uid,
    'name' => user.name,
    'email' => oauth[:info][:email],
    'accessToken' => oauth[:credentials][:token],
  }}
  let(:uid) { oauth[:uid] }

  subject { gql_query(query: mutation, variables: variables).to_h.deep_symbolize_keys.dig(:data, :omniauthLogin) }

  context 'when user has valid' do
    let(:user) { build(:user) }

    it 'Successful login/register' do
      subject
      expect(OauthProvider.count).to eq 1
      expect(User.count).to eq 1
      expect(subject[:success]).to be_truthy
      expect(subject[:errors]).to be_blank
    end
  end

  context 'when user exists' do
    let(:user) { create(:user) }
    let!(:oauth_provider) { create(:oauth_provider, uid: uid, name: provider, user: user) }

    it 'return exist record' do
      subject
      expect(OauthProvider.count).to eq(1)
      expect(User.count).to eq(1)
    end
  end
end
