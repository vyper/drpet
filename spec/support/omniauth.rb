module Omniauth
  module Mock
    def auth_mock(user)
      OmniAuth.config.mock_auth[:github] = OpenStruct.new(
        provider: 'facebook',
        uid: user.uid,
        info: OpenStruct.new(
          email: user.email
        )
      )
    end
  end
end

RSpec.configure do |config|
  config.include Omniauth::Mock
end

OmniAuth.config.test_mode = true
