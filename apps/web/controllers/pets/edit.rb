module Web::Controllers::Pets
  class Edit
    include Web::Action

    before :authenticate!

    expose :pet

    def call(params)
      @pet = PetRepository.find_owned_by(params[:id], current_user)
      halt 404 if @pet.nil?
    end
  end
end
