require 'spec_helper'

RSpec.describe Pet do
  context 'validations' do
    context '#name' do
      it 'blank' do
        expect(subject.valid?).to be_falsey
        expect(subject.errors.for(:name)).to include Lotus::Validations::Error.new(:name, :presence, true, nil)
      end

      it 'filled' do
        subject.name = 'the name'
        expect(subject.valid?).to be_truthy
        expect(subject.errors.for(:name)).to_not include Lotus::Validations::Error.new(:name, :presence, true, nil)
      end
    end
  end
end
