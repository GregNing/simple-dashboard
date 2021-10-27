require 'rails_helper'

RSpec.describe OauthProvider, type: :model do
  describe '#find_for_oauth' do
    subject { OauthProvider.find_for_oauth(auth) }
    let(:uuid) { Faker::IDNumber.valid_south_african_id_number }
    let(:provider) { OauthProvider::PROVIDER_NAME.sample }
    let(:auth) { double('auth') }

    before do
      allow(auth).to receive(:uid).and_return(uuid)
      allow(auth).to receive(:email).and_return(user.email)
      allow(auth).to receive(:name).and_return(user.name)
      allow(auth).to receive(:provider).and_return(provider)
    end

    context 'when record not exists' do
      let(:user) { build(:user) }

      it 'creates new record' do
        expect(subject.uid).to eq(auth.uid)
        expect(subject.name).to eq(auth.provider)
        expect(OauthProvider.count).to eq(1)
        expect(User.count).to eq(1)
      end
    end

    context 'when record exists' do
      let(:user) { create(:user) }
      let!(:oauth_provider) { create(:oauth_provider, uid: uuid, name: provider, user: user) }

      it 'return exist record' do
        expect(subject.uid).to eq(oauth_provider.uid)
        expect(subject.name).to eq(oauth_provider.name)
        expect(subject.user).to eq(oauth_provider.user)
        expect(OauthProvider.count).to eq(1)
        expect(User.count).to eq(1)
      end
    end
  end
end
