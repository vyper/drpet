require 'features_helper'

RSpec.describe 'OAuth' do
  let!(:user) { UserRepository.create(User.new(uid: '1234', email: 'leo@nospam.org', password: '123456')) }
  let!(:client_app) { ClientAppRepository.create(ClientApp.new(name: 'nome da aplicação', app_id: 'app_id', app_secret: 'app_secret', permissions: 'permissions', redirect_uri: 'http://localhost', user_id: user.id)) }

  context 'unlogged user' do
    it 'GET #new' do
      visit "/api/oauth/new?app_id=#{client_app.app_id}"

      expect(page).to have_current_path('//login')
    end
  end

  context 'logged user' do
    before { sign_in(user) }

    context 'GET #new' do
      it 'invalid param' do
        visit '/api/oauth/new'
        expect(page).to have_current_path('//')
      end

      it 'shows client app name' do
        visit "/api/oauth/new?app_id=#{client_app.app_id}"
        expect(page.body).to include client_app.name
      end

      it 'shows button to authorize' do
        visit "/api/oauth/new?app_id=#{client_app.app_id}"

        expect(page.body).to have_css 'button[type=submit]', text: 'Authorize this application'
      end
    end
  end

  after do
    PetRepository.clear
    ClientAppRepository.clear
    UserRepository.clear
  end
end
