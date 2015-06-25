require 'spec_helper'
require_relative '../../../../apps/api/controllers/pets/index'

describe Api::Controllers::Pets::Index do
  before do
    PetRepository.create(Pet.new(name: 'Bacon'))
    @pets = PetRepository.all
  end

  let(:action) { Api::Controllers::Pets::Index.new }
  let(:params) { Hash[] }

  it 'is successful' do
    response = action.call(params)

    expect(response[0]).to eq 200
  end
end
