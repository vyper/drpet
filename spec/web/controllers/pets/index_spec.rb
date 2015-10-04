require 'spec_helper'
require_relative '../../../../apps/web/controllers/pets/index'

describe Web::Controllers::Pets::Index do
  let(:action) { described_class.new }

  let!(:user) { UserRepository.create(User.new(email: 'leo@nospam.org', password: '123456')) }
  let!(:pet) { PetRepository.create(Pet.new(name: 'Bacon', user_id: user.id)) }

  after do
    PetRepository.clear
    UserRepository.clear
  end

  context 'logged user' do
    let(:params) { { 'rack.session' => { 'logged_user_id' => user.id } } }

    it 'is successful' do
      response = action.call(params)

      expect(response[0]).to eq 200
      expect(action.pets.first.id).to eq pet.id
    end

    it 'exposures pets' do
      response = action.call(params)

      expect(action.pets.first.id).to eq pet.id
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
