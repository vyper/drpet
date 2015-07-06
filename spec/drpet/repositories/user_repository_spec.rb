require 'spec_helper'

RSpec.describe UserRepository do
  let(:complete_user_params)    { { email: 'complete@nospam.org',    password: '123456', uid: '111111' } }
  let(:without_uid_user_params) { { email: 'without_uid@nospam.org', password: '123456' } }

  before do
    @complete_user    = UserRepository.create(User.new(complete_user_params))
    @without_uid_user = UserRepository.create(User.new(without_uid_user_params))
  end

  after do
    UserRepository.clear
  end

  describe '.find_by_email' do
    it 'when exist email' do
      expect(described_class.find_by_email(@complete_user.email)).to eq @complete_user
    end

    it 'when not exist email' do
      expect(described_class.find_by_email('alfred@nospam.org')).to be_nil
    end
  end

  describe '.find_by_uid' do
    it 'when exist uuid' do
      expect(described_class.find_by_uid(@complete_user.uid)).to eq @complete_user
    end

    it 'when not exist uuid' do
      expect(described_class.find_by_uid('654321')).to be_nil
    end
  end

  describe '.find_or_create_from_omniauth' do
    context 'when exist uid' do
      let(:info)  { { 'email' => @complete_user.email } }
      let(:oauth) { { 'uid' => @complete_user.uid, 'info' => info } }

      it 'returns user using uid' do
        expect(described_class.find_or_create_from_omniauth(oauth)).to eq @complete_user
      end

      it 'does not create a new user' do
        expect {
          described_class.find_or_create_from_omniauth(oauth)
        }.to_not change { UserRepository.all.count }
      end
    end

    context 'when does not exist uid and exist email' do
      let(:info)  { { 'email' => @without_uid_user.email } }
      let(:oauth) { { 'uid' => '222222', 'info' => info } }

      it 'returns user using email' do
        expect(described_class.find_or_create_from_omniauth(oauth).id).to eq @without_uid_user.id
      end

      it 'does not create a new user' do
        expect {
          described_class.find_or_create_from_omniauth(oauth)
        }.to_not change { UserRepository.all.count }
      end

      it 'saves uid when found user using email' do
        expect {
          described_class.find_or_create_from_omniauth(oauth)
        }.to change { UserRepository.find(@without_uid_user.id).uid }.from('').to('222222')
      end
    end

    context 'when user does not exist' do
      let(:info)  { { 'email' => 'alemon@nospam.org' } }
      let(:oauth) { { 'uid' => '333333', 'info' => info } }

      it 'returns new user' do
        expect(described_class.find_or_create_from_omniauth(oauth).id).to_not match [@without_uid_user.id, @complete_user.id]
      end

      it 'returns new user' do
        expect {
          described_class.find_or_create_from_omniauth(oauth)
        }.to change { UserRepository.all.count }.by(1)
      end

      it 'filled all attributes' do
        user = described_class.find_or_create_from_omniauth(oauth)
        expect(user.email).to eq oauth['info']['email']
        expect(user.uid).to eq oauth['uid']
        expect(user.password).to_not be_nil
      end
    end
  end
end
