require 'spec_helper'
require_relative '../../../../apps/web/controllers/user_sessions/facebook'

describe Web::Controllers::UserSessions::Facebook do
  let(:omniauth_auth) do
    OmniAuth::AuthHash.new({
      :provider => 'facebook',
      :uid => '111111',
      :info => {
        :email => 'vyper@maneh.org',
        :name => 'Leonardo Saraiva',
        :first_name => 'Leonardo',
        :last_name => 'Saraiva',
        :image => 'http://graph.facebook.com/10203775863231446/picture',
        :urls => { :Facebook => 'https://www.facebook.com/app_scoped_user_id/10203775863231446/' },
        :verified => true
      }
    })
  end
  let(:params)      { { 'omniauth.auth' => omniauth_auth } }
  let(:user_params) { { 'email' => 'vyper@maneh.org', 'password' => '123456' } }
  let(:action)      { described_class.new }

  # TODO: Can I improve this using fixtures or factory_girl?
  before { @user = UserRepository.create(User.new(user_params)) }
  after  { UserRepository.clear }

  it 'valid user is successful' do
    response = action.call(params)

    expect(response[0]).to eq 302
    # TODO How I can use routes.root_path?
    expect(response[1]['Location']).to eq '/'
    expect(action.exposures[:session][:logged_user_id]).to eq @user.id
    expect(action.exposures[:flash][:notice]).to eq 'Signed in successfully' # TODO: i18n
  end

  context 'error on find or create' do
    it 'fails' do
      expect(UserRepository).to receive(:find_or_create_from_omniauth).and_return(nil)

      response = action.call(params)

      expect(response[0]).to eq 302
      # TODO How I can use routes.new_session_path?
      expect(response[1]['Location']).to eq '/login'
      expect(action.exposures[:flash][:notice]).to eq 'PAM! Error on facebook authentication' # TODO: i18n
    end
  end
end
