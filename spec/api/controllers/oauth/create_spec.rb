require 'spec_helper'
require_relative '../../../../apps/api/controllers/oauth/create'

describe Api::Controllers::Oauth::Create do
  let(:action) { described_class.new }

  after do
    AuthGrantRepository.clear
    ClientAppRepository.clear
    UserRepository.clear
  end

  context 'logged user' do
    let(:user_params)  { { email: 'complete@nospam.org', password: '123456', uid: '111111' } }
    let(:app_params)   { { name: 'name', app_id: 'app_id', app_secret: 'app_secret', permissions: 'permissions' } }
    let(:redirect_uri) { 'http://localhost/' }
    let(:params)       { { 'client_app' => { 'app_id' => client_app.app_id, 'redirect_uri' => redirect_uri, permissions: [:read, :write] }, 'rack.session' => { 'logged_user_id' => user.id } } }

    let!(:user)       { UserRepository.create(User.new(user_params)) }
    let!(:client_app) { ClientAppRepository.create(ClientApp.new(app_params.merge(user_id: user.id))) }

    it 'is successful' do
      response = action.call(params)

      expect(response[0]).to eq 302
    end

    it 'creates a new auth grant when not exist' do
      expect {
        action.call(params)
      }.to change { AuthGrantRepository.all.size }
    end

    context 'redirects to request url' do
      it 'when ? not exists in url' do
        response = action.call(params)
        auth_grant = AuthGrantRepository.last
        expect(response[1]['Location']).to eq "http://localhost/?code=#{auth_grant.code}&response_type=code"
      end

      context 'when ? exists in url' do
        let(:redirect_uri) { 'http://localhost/?lala=lele' }

        it 'only complete query params' do
          response = action.call(params)
          auth_grant = AuthGrantRepository.last
          expect(response[1]['Location']).to eq "http://localhost/?lala=lele&code=#{auth_grant.code}&response_type=code"
        end
      end
    end

    context 'use when auth grant exists' do
      let(:auth_grant_params) { { code: 'code', access_token: 'access_token', refresh_token: 'refresh_token', permissions: '', user_id: user.id, client_app_id: client_app.id } }
      let!(:auth_grant) { AuthGrantRepository.create(AuthGrant.new(auth_grant_params)) }

      it 'is successful' do
        response = action.call(params)

        expect(response[0]).to eq 302
      end

      it 'does not creates a new auth grant' do
        expect {
          action.call(params)
        }.to_not change { AuthGrantRepository.all.size }
      end

      context 'redirects to request url' do
        it 'when ? not exists in url' do
          response = action.call(params)
          expect(response[1]['Location']).to eq "http://localhost/?code=#{auth_grant.code}&response_type=code"
        end

        context 'when ? exists in url' do
          let(:redirect_uri) { 'http://localhost/?lala=lele' }

          it 'only complete query params' do
            response = action.call(params)
            expect(response[1]['Location']).to eq "http://localhost/?lala=lele&code=#{auth_grant.code}&response_type=code"
          end
        end
      end
    end
  end

  context 'unlogged user' do
    let(:params) { Hash[] }

    it 'unauthorize' do
      response = action.call(params)

      # TODO Can I response 401? Is correct way?
      expect(response[0]).to eq 302
      # TODO How I can use routes.new_session_path?
      expect(response[1]['Location']).to eq '/login'
    end
  end
end
