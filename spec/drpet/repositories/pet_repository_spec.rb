require 'spec_helper'

RSpec.describe PetRepository do
  let(:user1_params) { { email: 'user1@nospam.org', password: '123456' } }
  let(:user2_params) { { email: 'user2@nospam.org', password: '123456' } }
  let(:pet1_params)  { { name: 'Pet #1', user_id: user1.id } }
  let(:pet2_params)  { { name: 'Pet #2', user_id: user2.id } }

  let!(:user1) { UserRepository.create(User.new(user1_params)) }
  let!(:user2) { UserRepository.create(User.new(user2_params)) }
  let!(:pet1)  { PetRepository.create(Pet.new(pet1_params)) }
  let!(:pet2)  { PetRepository.create(Pet.new(pet2_params)) }

  after do
    PetRepository.clear
    UserRepository.clear
  end

  context '.all_owned_by' do
    subject { PetRepository.all_owned_by(user1) }

    it 'list only pets owned by user' do
      expect(subject).to include pet1
    end

    it 'not list pets owned by other user' do
      expect(subject).to_not include pet2
    end
  end
end
