module Web::Controllers::UserSessions
  class Failure
    include Web::Action

    def call(params)
      flash[:notice] = 'Error on facebook authentication' # TODO i18n?
      redirect_to routes.new_user_session_path
    end
  end
end
