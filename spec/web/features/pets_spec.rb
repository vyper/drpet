require 'features_helper'

RSpec.describe 'Pets' do
  before do
    @user = UserRepository.create(User.new(uid: '1234', email: 'leo@nospam.org', password: '123456'))
  end

  after do
    PetRepository.clear
    UserRepository.clear
  end

  it 'unlogged user' do
    visit '/'

    expect(current_path).to eq '/login'
  end

  context 'logged user' do
    before do
      sign_in(@user)
    end

    it 'shows logout button' do
      visit '/'

      expect(page.body).to have_button 'Logout'
    end

    it 'without pets' do
      visit '/'
      expect(page.body).to have_content 'Pets'
      expect(page.body).to have_content 'No pets'
    end

    context 'with pets' do
      before do
        @pet1 = PetRepository.create(Pet.new(name: 'Bacon'))
        @pet2 = PetRepository.create(Pet.new(name: 'Zabelê'))
      end

      it 'displays all pets' do
        visit '/'

        expect(page.body).to have_css('li', count: 2)
        expect(page.body).to have_content @pet1.name
        expect(page.body).to have_content @pet2.name
        expect(page.body).to_not have_content 'No pets'
      end
    end
  end
end
