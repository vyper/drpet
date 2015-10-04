require 'json'

module Api::Controllers::Pets
  class Index
    include Api::Action

    before :authenticate!

    accept :json

    UrlDefault = 'http://placehold.it/80x80'.freeze
    # TODO Duplicated... );
    UrlAws     = "https://s3-sa-east-1.amazonaws.com/#{ENV['AWS_BUCKET']}/store/pets/".freeze

    def call(params)
      # TODO Move to serializer/presenter
      status 200, JSON.generate(PetRepository.owned_by(current_user).map { |pet| pet.to_h.merge(image_url: (pet.image_id.to_s.empty? ? UrlDefault : "#{UrlAws}#{pet.image_id}")).select { |k, v| [:id, :name, :image_url].include? k } })
    end
  end
end
