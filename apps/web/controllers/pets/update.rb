module Web::Controllers::Pets
  class Update
    include Web::Action

    before :authenticate!

    # TODO Move to other class
    params do
      param :id, type: Integer, presence: true
      param :pet do
        param :name, type: String, presence: true
      end
    end

    expose :pet

    def call(params)
      @pet = PetRepository.find_owned_by(params[:id], current_user)
      halt 404 if @pet.nil?
      @pet.update pet_params

      if params.valid?
        PetRepository.update(@pet)
        redirect_to routes.pets_path
      end
    end

    private

    def pet_params
      params[:pet]
    end
  end
end
