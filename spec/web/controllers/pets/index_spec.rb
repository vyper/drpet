require 'spec_helper'
require_relative '../../../../apps/web/controllers/pets/index'

describe Web::Controllers::Pets::Index do
  let(:action) { Web::Controllers::Pets::Index.new }
  let(:params) { Hash[] }

  it "is successful" do
    response = action.call(params)
    expect(response[0]).to eq 200
  end
end
