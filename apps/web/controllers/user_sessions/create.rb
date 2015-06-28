module Web::Controllers::UserSessions
  class Create
    include Web::Action

    def call(params)
      user = UserRepository.find_by_email(params['user']['email'])

      if user && user.password == params['user']['password']
        session[:logged_user_id] = user.id
        redirect_to routes.root_path
      else
        redirect_to routes.new_session_path
      end
    end

    private

    # TODO: Improve this!
    def authenticate!
    end
  end
end
