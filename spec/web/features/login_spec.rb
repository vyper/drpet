require 'features_helper'

RSpec.describe 'Login' do
  let(:email)    { 'leo@nospam.org' }
  let(:password) { '123456' }

  before do
    @user = UserRepository.create(User.new(uid: '1234', email: email, password: password))
  end

  after do
    UserRepository.clear
  end

  context 'using form' do
    it 'empty fields' do
      visit '/login'

      within 'form#user-form' do
        fill_in 'user-email',    with: ''
        fill_in 'user-password', with: ''

        click_button 'Login!'
      end

      expect(page.body).to have_content 'Invalid email or password'
      expect(page).to have_current_path('/login')
    end

    it 'invalid password' do
      visit '/login'

      within 'form#user-form' do
        fill_in 'user-email',    with: email
        fill_in 'user-password', with: '-'

        click_button 'Login!'
      end

      expect(page.body).to have_content 'Invalid email or password'
      expect(page).to have_current_path('/login')
    end

    it 'invalid email' do
      visit '/login'

      within 'form#user-form' do
        fill_in 'user-email',    with: 'alfred@nospam.org'
        fill_in 'user-password', with: password

        click_button 'Login!'
      end

      expect(page.body).to have_content 'Invalid email or password'
      expect(page).to have_current_path('/login')
    end

    it 'valid fields' do
      visit '/login'

      within 'form#user-form' do
        fill_in 'user-email',    with: email
        fill_in 'user-password', with: password

        click_button 'Login!'
      end

      expect(page.body).to have_content 'Signed in successfully'
      expect(page).to have_current_path('/')
    end
  end

  context 'using facebook' do
    it 'can login using valid credentials' do
      auth_mock(@user)

      visit '/login'
      click_link 'using facebook'

      expect(page.body).to have_content 'Signed in successfully'
      expect(page).to have_current_path('/')
    end

    it 'can not join using invalid credentials' do
      auth_failure_mock

      visit '/login'
      click_link 'using facebook'

      expect(page.body).to have_content 'Error on facebook authentication'
      expect(page).to have_current_path('/login')
    end
  end

  it 'can logout' do
    sign_in(@user)

    visit '/'
    click_button 'Logout'

    expect(page).to have_current_path('/login')
  end
end
