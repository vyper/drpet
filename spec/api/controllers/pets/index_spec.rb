require 'spec_helper'
require_relative '../../../../apps/api/controllers/pets/index'

describe Api::Controllers::Pets::Index do
  let(:action) { Api::Controllers::Pets::Index.new }

  let(:user_params) { { email: 'complete@nospam.org', password: '123456', uid: '111111' } }
  let(:app_params)  { { name: 'name', app_id: 'app_id', app_secret: 'app_secret', permissions: 'permissions', redirect_uri: 'http://localhost/oauth/callback', user_id: user.id } }
  let(:auth_params) { { code: 'code', access_token: 'access_token', refresh_token: 'refresh_token', permissions: 'permissions', client_app_id: client_app.id, user_id: user.id } }
  let(:params)      { { 'HTTP_ACCEPT' => 'application/json', 'HTTP_AUTHORIZATION' => "Authorization: token #{auth_grant.access_token}" } }

  let!(:bacon)      { PetRepository.create(Pet.new(name: 'Bacon')) }
  let!(:zabele)     { PetRepository.create(Pet.new(name: 'Zabelê')) }
  let!(:user)       { UserRepository.create(User.new(user_params)) }
  let!(:client_app) { ClientAppRepository.create(ClientApp.new(app_params)) }
  let!(:auth_grant) { AuthGrantRepository.create(AuthGrant.new(auth_params)) }

  after do
    AuthGrantRepository.clear
    ClientAppRepository.clear
    UserRepository.clear
    PetRepository.clear
  end

  context 'logged user' do
    it 'is successful' do
      response = action.call(params)

      expect(response[0]).to eq 200
    end

    it 'response array with pets' do
      response = action.call(params)
      pets = JSON.parse(response[2].first)

      expect(pets.first['name']).to eq bacon.name
      expect(pets.last['name']).to eq zabele.name
    end
  end

  context 'unlogged user' do
    let(:params) { { 'HTTP_ACCEPT' => 'application/json' } }

    it 'unauthorize' do
      response = action.call(params)

      expect(response[0]).to eq 401
    end
  end
end
