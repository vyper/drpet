require 'spec_helper'
require_relative '../../../../apps/web/controllers/pets/edit'

describe Web::Controllers::Pets::Edit do
  let(:action) { described_class.new }

  before do
    @user = UserRepository.create(User.new(email: 'leo@nospam.org', password: '123456'))
    @pet = PetRepository.create(Pet.new(name: 'Bacon', user_id: @user.id))
  end

  after do
    UserRepository.clear
    PetRepository.clear
  end

  context 'logged user' do
    let(:params) { { id: @pet.id, 'rack.session' => { 'logged_user_id' => @user.id } } }

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
