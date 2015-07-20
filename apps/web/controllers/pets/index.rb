module Web::Controllers::Pets
  class Index
    include Web::Action

    before :authenticate!

    expose :pets

    def call(params)
      @pets = PetRepository.all_owned_by(current_user)
    end
  end
end
