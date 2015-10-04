require 'spec_helper'
require_relative '../../fixtures/fixtures'

describe PetDestroyer do
  let!(:user) { UserRepository.create(User.new(email: 'leo@nospam.org', password: '123456')) }

  subject { described_class.new(pet) }

  after do
    PetRepository.clear
    UserRepository.clear
  end

  context 'with image' do
    let!(:pet) { PetRepository.create(Pet.new(name: 'Bacon', image_id: 'bacon.jpg', user_id: user.id)) }

    it 'deletes row and image' do
      expect_any_instance_of(Aws::S3::Client).to receive(:delete_object).with(hash_including(:bucket, :key))

      expect {
        subject.call
      }.to change { PetRepository.all.count }.by(-1)
    end
  end

  context 'without image' do
    let!(:pet) { PetRepository.create(Pet.new(name: 'Bacon', user_id: user.id)) }

    it 'deletes row and image' do
      expect_any_instance_of(Aws::S3::Client).to_not receive(:delete_object)

      expect {
        subject.call
      }.to change { PetRepository.all.count }.by(-1)
    end
  end
end
