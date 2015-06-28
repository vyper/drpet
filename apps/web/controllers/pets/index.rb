module Web::Controllers::Pets
  class Index
    include Web::Action

    expose :pets
    expose :flash

    def call(params)
      @pets = PetRepository.all
    end

    private

    # TODO: Improve this!
    def authenticate!
      unless session['logged_user_id']
        redirect_to routes.new_session_path
      end
    end
  end
end
