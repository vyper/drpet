module Web::Controllers::Pets
  class Index
    include Web::Action

    before :authenticate!

    expose :pets

    def call(params)
      # TODO Improve this...
      @pets = PetRepository.owned_by(current_user).map { |pet| PetPresenter.new(pet) }
    end
  end
end
