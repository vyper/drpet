module Web::Controllers::Pets
  class Edit
    include Web::Action

    before :authenticate!

    expose :pet

    def call(params)
      # TODO How I can apply more security here?
      @pet = PetRepository.find(params[:id])
    end
  end
end
