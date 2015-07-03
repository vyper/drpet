module Web::Controllers::Pets
  class Index
    include Web::Action

    before :authenticate!

    expose :pets

    def call(params)
      @pets = PetRepository.all
    end

    private

    # TODO: Improve this!
    def authenticate!
      unless session['logged_user_id']
        redirect_to routes.new_user_session_path
      end
    end
  end
end
