module Web::Controllers::Pets
  class Destroy
    include Web::Action

    before :authenticate!

    def call(params)
      @pet = PetRepository.find_owned_by(params[:id], current_user)
      halt 404 if @pet.nil?
      PetDestroyer.new(@pet).call

      redirect_to routes.pets_path
    end
  end
end
