require 'spec_helper'
require_relative '../../../../apps/web/controllers/pets/index'

describe Web::Controllers::Pets::Index do
  let(:action) { Web::Controllers::Pets::Index.new }

  context 'logged user' do
    let(:params) { { 'rack.session' => { 'logged_user_id' => 1 } } }

    before do
      PetRepository.create(Pet.new(name: 'Bacon'))
      @pets = PetRepository.all
    end

    it 'is successful' do
      response = action.call(params)

      expect(response[0]).to eq 200
      expect(action.pets).to eq @pets
    end

    it 'exposures pets' do
      response = action.call(params)

      expect(action.pets).to eq @pets
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
