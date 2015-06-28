require 'spec_helper'
require_relative '../../../../apps/web/controllers/user_sessions/destroy'

describe Web::Controllers::UserSessions::Destroy do
  let(:action) { described_class.new }

  context 'logged user' do
    let(:params) { { 'rack.session' => { 'logged_user_id' => 1 } } }

    it 'removes logged user and redirects to root' do
      response = action.call(params)

      expect(response[0]).to eq 302
      # TODO How I can use routes.root_path?
      expect(response[1]['Location']).to eq '/'

      expect(action.exposures[:session][:logged_user_id]).to be_nil
    end
  end

  context 'unlogged user' do
    let(:params) { Hash[] }

    it 'redirects' do
      response = action.call(params)

      expect(response[0]).to eq 302
      # TODO How I can use routes.root_path?
      expect(response[1]['Location']).to eq '/'
    end
  end
end
