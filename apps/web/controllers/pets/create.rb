module Web::Controllers::Pets
  class Create
    include Web::Action

    before :authenticate!

    # TODO Move to other class
    params do
      param :pet do
        param :name, type: String, presence: true
      end
    end

    expose :pet

    def call(params)
      @pet = Pet.new pet_params
      @pet.user_id = current_user.id # TODO Improve this

      if params.valid?
        PetRepository.create(@pet)
        redirect_to routes.pets_path
      end
    end

    private

    def pet_params
      params[:pet]
    end
  end
end
