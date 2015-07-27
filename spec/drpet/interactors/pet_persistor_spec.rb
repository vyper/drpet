require 'spec_helper'
require_relative '../../fixtures/fixtures'

describe PetPersistor do
  let(:user)       { UserRepository.create(User.new(email: 'leo@nospam.org', password: '123456')) }
  let(:pet_params) { { 'pet' => { } } }

  subject { described_class.new(params, user) }

  after do
    PetRepository.clear
    UserRepository.clear
  end

  context 'creates a pet' do
    let(:params) { CreatePetParams.new(pet_params) }

    context 'valid params' do
      let(:pet_params) { { 'pet' => { 'name' => 'Bacon' } } }

      it 'persists' do
        expect {
          subject.call
        }.to change { PetRepository.all.count }.by(1)
      end
    end

    context 'invalid params' do
      it 'does not successfully' do
        result = subject.call
        expect(result.success?).to be_falsey
      end

      it 'does not persist' do
        expect {
          subject.call
        }.to_not change { PetRepository.all.count }
      end
    end
  end

  context 'updates a pet' do
    let(:params) { UpdatePetParams.new(pet_params) }

    context 'inexistent' do
      let(:pet_params) { { 'id' => 1, 'pet' => { 'name' => 'Bacon' } } }

      it 'does not successfully' do
        result = subject.call
        expect(result.success?).to be_falsey
      end
    end

    context 'existent' do
      let(:pet)        { PetRepository.create(Pet.new(name: 'Bacon', user_id: user.id)) }
      let(:pet_params) { { 'id' => pet.id, 'pet' => { 'name' => 'Bacon #2' } } }

      it 'successfully' do
        result = subject.call
        expect(result.success?).to be_truthy
      end

      it 'changes fields' do
        expect {
          subject.call
        }.to change { PetRepository.find(pet.id).name }.from('Bacon').to('Bacon #2')
      end
    end
  end
end
