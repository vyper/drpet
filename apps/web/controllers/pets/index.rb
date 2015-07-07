module Web::Controllers::Pets
  class Index
    include Web::Action

    before :authenticate!

    expose :pets

    def call(params)
      @pets = PetRepository.all
    end
  end
end
