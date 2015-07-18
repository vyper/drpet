module Web::Controllers::UserSessions
  class Create
    include Web::Action

    def call(params)
      user = UserRepository.find_by_email(params['user']['email'])

      if user && user.password == params['user']['password']
        sign_in_and_redirect(user)
      else
        flash[:notice] = 'Invalid email or password' # TODO i18n?
        redirect_to routes.new_user_session_path
      end
    end
  end
end
