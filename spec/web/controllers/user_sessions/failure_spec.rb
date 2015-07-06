require 'spec_helper'
require_relative '../../../../apps/web/controllers/user_sessions/failure'

describe Web::Controllers::UserSessions::Failure do
  let(:action) { described_class.new }

  it 'redirects to login path' do
    response = action.call({})

    expect(response[0]).to eq 302
    # TODO How I can use routes.new_session_path?
    expect(response[1]['Location']).to eq '/login'
    expect(action.exposures[:flash][:notice]).to eq 'Error on facebook authentication' # TODO: i18n
  end
end
