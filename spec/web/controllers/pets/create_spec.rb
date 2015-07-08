require 'spec_helper'
require_relative '../../../../apps/web/controllers/pets/create'

describe Web::Controllers::Pets::Create do
  let(:action) { described_class.new }

  before do
    @user = UserRepository.create(User.new(email: 'leo@nospam.org', password: '123456'))
  end

  after do
   UserRepository.clear
   PetRepository.clear
 end

  context 'logged user' do
    let(:rack_session) { { 'logged_user_id' => @user.id } }
    let(:params) { { 'pet' => pet_params, 'rack.session' => rack_session } }

    context 'invalid params' do
      let(:pet_params) { { 'name' => '' } }

      it 'render form with errors'

      it 'does not redirect' do
        response = action.call(params)

        expect(response[0]).to eq 200
      end
    end

    context 'valid params' do
      let(:pet_params) { { 'name' => 'Bacon' } }

      it 'redirect to pets' do
        response = action.call(params)

        expect(response[0]).to eq 302
        expect(response[1]['Location']).to eq '/pets'
      end

      it 'saves a pet' do
        expect { action.call(params) }.to change { PetRepository.all.size }.from(0).to(1)
      end
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
