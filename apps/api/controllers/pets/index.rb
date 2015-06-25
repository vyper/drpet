require 'json'

module Api::Controllers::Pets
  class Index
    include Api::Action

    accept :json

    def call(params)
      # TODO Move to serializer/presenter
      status 200, JSON.generate(PetRepository.all.map { |pet| pet.to_h.select { |k, v| [:id, :name].include? k } })
    end
  end
end
