module Web::Controllers::Pets
  class Create
    include Web::Action

    before :authenticate!

    # TODO Move to other class
    params do
      param :pet do
        param :name, presence: true
        param :image
      end
    end

    expose :pet

    def call(params)
      result = PetPersistor.new(params, current_user).call
      @pet = result.pet

      if result.success?
        redirect_to routes.pets_path
      end
    end
  end
end
