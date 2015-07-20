require 'spec_helper'

RSpec.describe ClientAppRepository do
  let(:user_params) { { email: 'complete@nospam.org', password: '123456', uid: '111111' } }
  let(:params)      { { name: 'name', app_id: 'app_id', app_secret: 'app_secret', permissions: 'permissions', redirect_uri: 'http://localhost/' } }

  let!(:user)       { UserRepository.create(User.new(user_params)) }
  let!(:client_app) { ClientAppRepository.create(ClientApp.new(params.merge(user_id: user.id))) }

  after do
    ClientAppRepository.clear
    UserRepository.clear
  end

  describe '.find_by_app_id' do
    it 'when exists' do
      expect(described_class.find_by_app_id(client_app.app_id)).to eq client_app
    end

    it 'when not exists' do
      expect(described_class.find_by_app_id('inexistent')).to be_nil
    end
  end

  describe '.authenticate' do
    it 'when exists' do
      expect(described_class.authenticate(client_app.app_id, client_app.app_secret)).to eq client_app
    end

    it 'when not exists' do
      expect(described_class.authenticate('inexistent', 'inexistent')).to be_nil
    end
  end
end
