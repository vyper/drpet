module Web::Controllers::UserSessions
  class Facebook
    include Web::Action

    def call(params)
      user = UserRepository.find_or_create_from_omniauth(params.env['omniauth.auth'])

      if user
        session[:logged_user_id] = user.id
        flash[:notice] = 'Signed in successfully' # TODO i18n?
        redirect_to routes.root_path
      else
        flash[:notice] = 'PAM! Error on facebook authentication' # TODO i18n?
        redirect_to routes.new_user_session_path
      end
    end

    private

    # TODO: Improve this!
    def authenticate!
    end
  end
end
