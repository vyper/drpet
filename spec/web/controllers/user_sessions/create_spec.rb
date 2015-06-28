require 'spec_helper'
require_relative '../../../../apps/web/controllers/user_sessions/create'

describe Web::Controllers::UserSessions::Create do
  let(:action)      { described_class.new }
  let(:user_params) { { 'email' => 'leo@nospam.org', 'password' => '123456' } }
  let(:params)      { { 'user' => user_params } }

  # TODO: Can I improve this using fixtures or factory_girl?
  before { @user = UserRepository.create(User.new(user_params)) }
  after  { UserRepository.delete(@user) }

  it 'valid user is successful' do
    response = action.call(params)

    expect(response[0]).to eq 302
    # TODO How I can use routes.root_path?
    expect(response[1]['Location']).to eq '/'
    expect(action.exposures[:session][:logged_user_id]).to eq @user.id
  end

  context 'invalid password' do
    let(:params) { { 'user' => { 'email' => 'leo@nospam.org', 'password' => '123' } } }

    it 'fails' do
      response = action.call(params)

      expect(response[0]).to eq 302
      # TODO How I can use routes.new_session_path?
      expect(response[1]['Location']).to eq '/login'
    end
  end

  context 'invalid email' do
    let(:params) { { 'user' => { 'email' => 'leo@nospam.xxx', 'password' => '123' } } }

    it 'fails' do
      response = action.call(params)

      expect(response[0]).to eq 302
      # TODO How I can use routes.new_session_path?
      expect(response[1]['Location']).to eq '/login'
    end
  end
end
