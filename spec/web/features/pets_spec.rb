require 'features_helper'

RSpec.describe 'Pets' do
  before do
    @user = UserRepository.create(User.new(uid: '1234', email: 'leo@nospam.org', password: '123456'))
  end

  after do
    PetRepository.clear
    UserRepository.clear
  end

  context 'unlogged user' do
    it 'index' do
      visit '/'

      expect(current_path).to eq '/login'
    end

    it 'new' do
      visit '/pets/new'

      expect(current_path).to eq '/login'
    end
  end

  context 'logged user' do
    before do
      sign_in(@user)
    end

    context 'index' do
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

        after do
          PetRepository.clear
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

    context 'new' do
      it 'shows logout button' do
        visit '/pets/new'

        expect(page.body).to have_button 'Logout'
      end

      it 'create a new pet' do
        visit '/pets/new'

        within '#pet-form' do
          fill_in 'pet-name', with: 'Romeo'
        end

        click_on 'Create'

        expect(current_path).to eq '/pets'
        expect(page.body).to have_css('li')
        expect(page.body).to have_content 'Romeo'
        expect(page.body).to_not have_content 'No pets'
      end
    end

    context 'destroy' do
      before do
        @pet = PetRepository.create(Pet.new(name: 'Bacon'))
      end

      it 'destroys a pet' do
        visit '/pets'

        within 'ul' do
          click_on 'Destroy'
        end

        expect(current_path).to eq '/pets'
        expect(page.body).to_not have_css('li')
        expect(page.body).to_not have_content 'Bacon'
        expect(page.body).to have_content 'No pets'
      end
    end
  end
end
