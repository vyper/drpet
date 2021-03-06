module Omniauth
  module Mock
    def auth_mock(user)
      OmniAuth.config.mock_auth[:facebook] = OpenStruct.new(
        provider: 'facebook',
        uid: user.uid,
        info: OpenStruct.new(
          email: user.email
        )
      )
    end

    def auth_failure_mock
      OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
    end
  end

  module SessionHelpers
    def sign_in(user)
      visit '/login'
      expect(page).to have_content('using facebook')
      auth_mock(user)
      click_link 'using facebook'
    end
  end
end

RSpec.configure do |config|
  config.include Omniauth::Mock
  config.include Omniauth::SessionHelpers, type: :feature
end

OmniAuth.config.test_mode = true
