require 'spec_helper'
require_relative '../../../../apps/web/views/pets/edit'

describe Web::Views::Pets::Edit do
  let(:exposures) { Hash[pet: pet] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/pets/edit.html.erb') }
  let(:view)      { Web::Views::Pets::Edit.new(template, exposures) }
  let(:rendered)  { view.render }
  let(:pet)       { PetRepository.create(Pet.new(name: 'Bacon', image_id: 'image_id.jpg', user_id: user.id)) }
  let(:user)      { UserRepository.create(User.new(email: 'leo@nospam.org', password: '123456')) }

  after do
    UserRepository.clear
    PetRepository.clear
  end

  it 'exposes #pet' do
    expect(view.pet).to eq exposures.fetch(:pet)
  end

  it '#pet_image_tag'
end
