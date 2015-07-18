module Web::Controllers::UserSessions
  class Facebook
    include Web::Action

    def call(params)
      user = UserRepository.find_or_create_from_omniauth(params.env['omniauth.auth'])

      if user
        sign_in_and_redirect(user)
      else
        flash[:notice] = 'PAM! Error on facebook authentication' # TODO i18n?
        redirect_to routes.new_user_session_path
      end
    end
  end
end
