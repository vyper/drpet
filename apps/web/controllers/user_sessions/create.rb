module Web::Controllers::UserSessions
  class Create
    include Web::Action

    expose :flash

    def call(params)
      user = UserRepository.find_by_email(params['user']['email'])

      if user && user.password == params['user']['password']
        session[:logged_user_id] = user.id
        flash[:notice] = 'Signed in successfully' # TODO i18n?
        redirect_to routes.root_path
      else
        flash[:notice] = 'Invalid email or password' # TODO i18n?
        redirect_to routes.new_user_session_path
      end
    end

    private

    # TODO: Improve this!
    def authenticate!
    end
  end
end
