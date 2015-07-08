module Web::Controllers::Pets
  class Destroy
    include Web::Action

    before :authenticate!

    def call(params)
      @pet = PetRepository.find(params[:id])
      PetRepository.delete(@pet)

      redirect_to routes.pets_path
    end
  end
end
