require 'spec_helper'
require_relative '../../../../apps/api/controllers/oauth/new'

describe Api::Controllers::Oauth::New do
  let(:action) { described_class.new }

  after do
    ClientAppRepository.clear
    UserRepository.clear
  end

  context 'logged user' do
    let(:user_params)  { { email: 'complete@nospam.org', password: '123456', uid: '111111' } }
    let(:app_params)   { { name: 'name', app_id: 'app_id', app_secret: 'app_secret', permissions: 'permissions' } }
    let(:redirect_uri) { 'http://localhost' }
    let(:params)       { { 'app_id' => client_app.app_id, 'redirect_uri' => redirect_uri, 'rack.session' => { 'logged_user_id' => user.id } } }

    let!(:user)       { UserRepository.create(User.new(user_params)) }
    let!(:client_app) { ClientAppRepository.create(ClientApp.new(app_params.merge(user_id: user.id))) }

    it 'is successful' do
      response = action.call(params)

      expect(response[0]).to eq 200
    end

    it 'exposures client_app' do
      response = action.call(params)

      expect(action.client_app).to eq client_app
    end

    it 'exposures redirect_uri' do
      response = action.call(params)

      expect(action.redirect_uri).to eq redirect_uri
    end

    it 'check params is valid'
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
