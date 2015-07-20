require 'spec_helper'
require_relative '../../../../apps/api/controllers/oauth/access_token'

describe Api::Controllers::Oauth::AccessToken do
  let(:action) { described_class.new }

  after do
    AuthGrantRepository.clear
    ClientAppRepository.clear
    UserRepository.clear
  end

  let(:user_params) { { email: 'complete@nospam.org', password: '123456', uid: '111111' } }
  let(:app_params)  { { name: 'name', app_id: 'app_id', app_secret: 'app_secret', permissions: 'permissions', redirect_uri: 'http://localhost/oauth/callback', user_id: user.id } }
  let(:auth_params) { { code: 'code', access_token: 'access_token', refresh_token: 'refresh_token', permissions: 'permissions', client_app_id: client_app.id, user_id: user.id } }
  let(:params)      { { code: 'code', app_id: client_app.app_id, app_secret: client_app.app_secret } }

  let!(:user)       { UserRepository.create(User.new(user_params)) }
  let!(:client_app) { ClientAppRepository.create(ClientApp.new(app_params)) }
  let!(:auth_grant) { AuthGrantRepository.create(AuthGrant.new(auth_params)) }

  it 'invalid params'

  it 'is successful' do
    response = action.call(params)

    expect(response[0]).to eq 200
  end

  it 'unauthorize inexistent app' do
    response = action.call(params.merge({ app_id: 'inexistent', app_secret: 'inexistent' }))
    expect(response[0]).to eq 401
  end
end
