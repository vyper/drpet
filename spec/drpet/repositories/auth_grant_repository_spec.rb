require 'spec_helper'

RSpec.describe AuthGrantRepository do
  let(:user_params)       { { email: 'complete@nospam.org', password: '123456', uid: '111111' } }
  let(:client_app_params) { { name: 'name', app_id: 'app_id', app_secret: 'app_secret', permissions: 'permissions', user_id: user.id, redirect_uri: 'http://localhost/' } }
  let(:params)            { { code: 'code', access_token: 'access_token', refresh_token: 'refresh_token', permissions: 'permissions', client_app_id: client_app.id, user_id: user.id } }

  let!(:user)       { UserRepository.create(User.new(user_params)) }
  let!(:client_app) { ClientAppRepository.create(ClientApp.new(client_app_params)) }

  after do
    ClientAppRepository.clear
    UserRepository.clear
  end

  describe '.find_or_create_by_client_app_id_and_user_id' do
    subject { described_class.find_or_create_by_client_app_id_and_user_id(client_app.id, user.id) }

    context 'when exists' do
      let!(:auth_grant) { AuthGrantRepository.create(AuthGrant.new(params)) }

      it 'returns existent auth grant' do
        expect(subject).to eq auth_grant
      end
    end

    context 'when not exists' do
      it 'returns an instance of auth grant' do
        expect(subject).to be_a(AuthGrant)
      end

      it 'persists a new auth grant' do
        expect(subject.id).to be_a(Integer)
      end

      it 'returns an instance associate to client_app' do
        expect(subject.client_app_id).to eq client_app.id
      end

      it 'returns an instance associate to user_id' do
        expect(subject.user_id).to eq user.id
      end
    end
  end

  describe '.find_by_app_id_and_user_id' do
    subject { described_class.find_by_app_id_and_user_id(client_app.id, user.id) }

    context 'when exists' do
      let!(:auth_grant) { AuthGrantRepository.create(AuthGrant.new(params)) }

      it 'returns existent auth grant' do
        expect(subject).to eq auth_grant
      end
    end

    context 'when not exists' do
      it 'returns an instance of auth grant' do
        expect(subject).to be_nil
      end
    end
  end

  describe '.unique_token_for' do
    let(:attribute) { :code }
    subject { described_class.unique_token_for(attribute, value) }

    context 'when value not exists' do
      let(:value) { SecureRandom.hex }

      it 'returns the value' do
        expect(subject).to eq value
      end
    end

    context 'generate a new value when exists' do
      let!(:auth_grant) { AuthGrantRepository.create(AuthGrant.new(params)) }
      let(:value) { auth_grant.code }

      it 'generate a new value' do
        expect(SecureRandom).to receive(:hex).and_return('obladi')

        expect(subject).to eq 'obladi'
      end
    end
  end

  describe '.unique_token_for_code' do
    subject { described_class.unique_token_for_code }

    it 'returns a unique code' do
      expect(described_class).to receive(:unique_token_for).with(:code).and_return('code')
      expect(subject).to eq 'code'
    end
  end

  describe '.unique_token_for_access_token' do
    subject { described_class.unique_token_for_access_token }

    it 'returns a unique access token' do
      expect(described_class).to receive(:unique_token_for).with(:access_token).and_return('access_token')
      expect(subject).to eq 'access_token'
    end
  end

  describe '.unique_token_for_refresh_token' do
    subject { described_class.unique_token_for_refresh_token }

    it 'returns a unique refresh token' do
      expect(described_class).to receive(:unique_token_for).with(:refresh_token).and_return('refresh_token')
      expect(subject).to eq 'refresh_token'
    end
  end
end
