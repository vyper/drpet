require 'spec_helper'
require_relative '../../../../apps/web/controllers/user_sessions/new'

describe Web::Controllers::UserSessions::New do
  let(:action) { described_class.new }
  let(:params) { Hash[] }

  it 'is successful' do
    response = action.call(params)

    expect(response[0]).to eq 200
  end
end
