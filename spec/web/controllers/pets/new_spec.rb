require 'spec_helper'
require_relative '../../../../apps/web/controllers/pets/new'

describe Web::Controllers::Pets::New do
  let(:action) { described_class.new }

  before { @user = UserRepository.create(User.new(email: 'leo@nospam.org', password: '123456')) }
  after  { UserRepository.clear }

  context 'logged user' do
    let(:params) { { 'rack.session' => { 'logged_user_id' => @user.id } } }

    it 'is successful' do
      response = action.call(params)

      expect(response[0]).to eq 200
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
