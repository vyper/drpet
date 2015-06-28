require 'spec_helper'

RSpec.describe User do
  context 'validations' do
    subject { described_class.new email: 'leo@nospam.org', password: '123456' }

    context '#email' do
      it 'blank' do
        subject.email = nil

        expect(subject.valid?).to be_falsey
        expect(subject.errors.for(:email)).to include Lotus::Validations::Error.new(:email, :presence, true, nil)
      end

      it 'invalid format' do
        subject.email = 'invalid email'

        expect(subject.valid?).to be_falsey
        expect(subject.errors.for(:email)).to include Lotus::Validations::Error.new(:email, :format, described_class::REGEX_EMAIL, subject.email)
      end

      it 'filled' do
        expect(subject.valid?).to be_truthy
        expect(subject.errors.for(:email)).to_not include Lotus::Validations::Error.new(:email, :presence, true, nil)
      end
    end

    context '#password' do
      it 'blank' do
        subject.password = nil

        expect(subject.valid?).to be_falsey
        expect(subject.errors.for(:password)).to include Lotus::Validations::Error.new(:password, :presence, true, nil)
      end

      it 'filled' do
        expect(subject.valid?).to be_truthy
        expect(subject.errors.for(:password)).to_not include Lotus::Validations::Error.new(:password, :presence, true, nil)
      end
    end
  end

  context 'encrypt password' do
    context 'when password receive nil' do
      subject { described_class.new password: nil }

      it 'sets nil to password' do
        expect(subject.password).to be_nil
      end

      it 'sets nil to encrypted_password' do
        expect(subject.encrypted_password).to be_nil
      end
    end

    context 'when password receive empty' do
      subject { described_class.new password: '' }

      it 'sets nil to password' do
        expect(subject.password).to be_nil
      end

      it 'sets nil to encrypted_password' do
        expect(subject.encrypted_password).to be_nil
      end
    end

    context 'when password receive a password' do
      let(:password)           { 'senha' }
      let(:encrypted_password) { '53nh4' }

      subject { described_class.new password: password }

      before do
        expect(BCrypt::Password).to receive(:create).
                                      with(password).
                                      and_return(encrypted_password)
      end

      it 'sets encrypted password to password' do
        expect(subject.password).to eq encrypted_password
      end

      it 'sets encrypted password to encrypted_password' do
        expect(subject.encrypted_password).to eq encrypted_password
      end
    end

    context 'returns encrypted password on password to compare' do
      context 'when exists encrypted_password' do
        let(:password)           { 'senha' }
        let(:encrypted_password) { BCrypt::Password.create(password) }

        subject { described_class.new encrypted_password: encrypted_password }

        it 'returns encrypted password' do
          expect(subject.password).to eq password
        end
      end

      it 'when does not exists encrypted_password' do
        expect(subject.password).to be_nil
      end
    end
  end
end
