require 'lotus/interactor'

class PetDestroyer
  include Lotus::Interactor

  expose :pet

  def initialize(pet)
    @pet = pet
  end

  def call
    PetRepository.delete(@pet)

    if not @pet.image_id.empty?
      client.delete_object bucket: ENV['AWS_BUCKET'], key: "store/pets/#{@pet.image_id}"
    end
  end

  private

  def client
    @client ||= Aws::S3::Client.new
  end
end
