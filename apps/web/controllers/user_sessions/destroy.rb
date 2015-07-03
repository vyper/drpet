module Web::Controllers::UserSessions
  class Destroy
    include Web::Action

    def call(params)
      flash[:notice] = 'Signed out successfull' # TODO i18n?
      session[:logged_user_id] = nil
      redirect_to routes.root_path
    end

    private

    # TODO: Improve this!
    def authenticate!
    end
  end
end
