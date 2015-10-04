require 'spec_helper'
require_relative '../../../apps/web/presenters/pet_presenter'

describe PetPresenter do
  subject { described_class.new(pet) }

  describe '#image_url' do
    context 'with image_id' do
      let(:pet) { Pet.new(name: 'Bacon') }

      it { expect(subject.image_url).to eq PetPresenter::UrlDefault }
    end

    context 'without image_id' do
      let(:pet) { Pet.new(name: 'Bacon', image_id: 'x.jpg') }

      it { expect(subject.image_url).to eq "#{PetPresenter::UrlAws}x.jpg" }
    end
  end
end
