require 'json'

module Api::Controllers::Pets
  class Index
    include Api::Action

    before :authenticate!

    accept :json

    def call(params)
      # TODO Move to serializer/presenter
      status 200, JSON.generate(PetRepository.owned_by(current_user).map { |pet| pet.to_h.select { |k, v| [:id, :name].include? k } })
    end
  end
end
