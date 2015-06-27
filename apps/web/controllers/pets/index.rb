module Web::Controllers::Pets
  class Index
    include Web::Action

    expose :pets

    def call(params)
      @pets = PetRepository.all
    end

    private

    # TODO: Improve this!
    def authenticate!
      redirect_to routes.new_session_path unless session[:logged_user_id]
    end
  end
end
