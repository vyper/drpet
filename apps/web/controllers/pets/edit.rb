module Web::Controllers::Pets
  class Edit
    include Web::Action

    before :authenticate!

    expose :pet

    def call(params)
      @pet = PetRepository.find(params[:id])
    end
  end
end
