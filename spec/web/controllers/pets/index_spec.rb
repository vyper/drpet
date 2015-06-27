require 'spec_helper'
require_relative '../../../../apps/web/controllers/pets/index'

describe Web::Controllers::Pets::Index do
  before do
    PetRepository.create(Pet.new(name: 'Bacon'))
    @pets = PetRepository.all
  end

  let(:action) { Web::Controllers::Pets::Index.new }
  let(:params) { Hash[] }

  xit 'is successful' do
    response = action.call(params)

    expect(response[0]).to eq 200
    expect(action.pets).to eq @pets
  end

  xit 'exposures pets' do
    response = action.call(params)

    expect(action.pets).to eq @pets
  end
end
