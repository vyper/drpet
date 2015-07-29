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
      context 'without image' do
        let(:pet_params) { { 'pet' => { 'name' => 'Bacon' } } }

        it 'persists' do
          expect {
            subject.call
          }.to change { PetRepository.all.count }.by(1)
        end
      end

      context 'with image' do
        let(:image_path) { File.expand_path('../../../support/vyper.jpg', __FILE__) }
        let(:image)      { { 'filename' => 'vyper.jpg', 'type' => 'image/jpeg', 'name' => 'image', 'tempfile' => File.open(image_path) } }
        let(:pet_params) { { 'pet' => { 'name' => 'Bacon', 'image' => image } } }

        it 'persists and upload image' do
          expect_any_instance_of(Aws::S3::Client).to receive(:put_object).with(hash_including(:bucket, :key, :body, :acl))
          expect_any_instance_of(Aws::S3::Client).to receive(:copy_object).with(hash_including(:bucket, :key, :copy_source, :acl))
          expect_any_instance_of(Aws::S3::Client).to receive(:delete_object).with(hash_including(:bucket, :key))

          expect {
            subject.call
          }.to change { PetRepository.all.count }.by(1)
        end
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
      let(:pet) { PetRepository.create(Pet.new(name: 'Bacon', user_id: user.id)) }

      context 'without image' do
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

      context 'with image' do
        let(:image_path) { File.expand_path('../../../support/vyper.jpg', __FILE__) }
        let(:image)      { { 'filename' => 'download.jpeg', 'type' => 'image/jpeg', 'name' => 'image', 'tempfile' => File.open(image_path) } }
        let(:pet_params) { { 'id' => pet.id, 'pet' => { 'name' => 'Bacon #2', 'image' => image } } }

        before do
          expect_any_instance_of(Aws::S3::Client).to receive(:put_object).with(hash_including(:bucket, :key, :body, :acl))
          expect_any_instance_of(Aws::S3::Client).to receive(:copy_object).with(hash_including(:bucket, :key, :copy_source, :acl))
          expect_any_instance_of(Aws::S3::Client).to receive(:delete_object).with(hash_including(:bucket, :key))
        end

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
end
