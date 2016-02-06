require 'features_helper'

RSpec.describe 'Pets' do
  let!(:user) { UserRepository.create(User.new(uid: '1234', email: 'leo@nospam.org', password: '123456')) }

  after do
    PetRepository.clear
    UserRepository.clear
  end

  context 'unlogged user' do
    it 'index' do
      visit '/'

      expect(page).to have_current_path('/login')
    end

    it 'new' do
      visit '/pets/new'

      expect(page).to have_current_path('/login')
    end
  end

  context 'logged user' do
    before do
      sign_in(user)
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
        let!(:pet1) { PetRepository.create(Pet.new(name: 'Bacon', user_id: user.id)) }
        let!(:pet2) { PetRepository.create(Pet.new(name: 'Zabelê', user_id: user.id)) }

        it 'displays all pets' do
          visit '/'

          expect(page.body).to have_css('.media-heading', count: 2)
          expect(page.body).to have_content pet1.name
          expect(page.body).to have_content pet2.name
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

        expect(page).to have_current_path('/pets')
        expect(page.body).to have_css('.media-heading', text: 'Romeo')
        expect(page.body).to_not have_content 'No pets'
      end
    end

    context 'edit' do
      let!(:pet) { PetRepository.create(Pet.new(name: 'Bacon', user_id: user.id)) }

      it 'shows logout button' do
        visit "/pets/#{pet.id}/edit"

        expect(page.body).to have_button 'Logout'
      end

      it 'edit a pet' do
        visit "/pets/#{pet.id}/edit"

        within '#pet-form' do
          fill_in 'pet-name', with: 'Zabelê'
        end

        click_on 'Update'

        expect(page).to have_current_path('/pets')
        expect(page.body).to have_css('.media-heading', text: 'Zabelê')
        expect(page.body).to_not have_content 'No pets'
      end
    end

    context 'destroy' do
      let!(:pet) { PetRepository.create(Pet.new(name: 'Bacon', user_id: user.id)) }

      it 'destroys a pet' do
        visit '/pets'

        within '.media-body' do
          click_on 'Destroy'
        end

        expect(page).to have_current_path('/pets')
        expect(page.body).to_not have_css('.media-heading')
        expect(page.body).to_not have_content 'Bacon'
        expect(page.body).to have_content 'No pets'
      end
    end
  end
end
