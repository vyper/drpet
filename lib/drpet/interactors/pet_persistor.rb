require 'lotus/interactor'

class PetPersistor
  include Lotus::Interactor

  expose :params, :user, :pet

  def initialize(params, user)
    @params = params
    @user   = user
    @pet    = Pet.new(params.get('pet'))
  end

  def call
    # TODO: Change this process to flow:
    #       1. Upload image to temp bucket
    #       2. Persist entity
    #       3. Move from temp bucket to official bucket
    persist!
    upload_image!
  end

  private

  def persist!
    if @params.get('id')
      @pet = PetRepository.find_owned_by(@params.get('id'), @user)
      error! 'Pet not found' unless @pet
    else
      @pet = Pet.new @params.get('pet')
    end

    @pet.update @params.get('pet')
    error! 'Invalid params' unless @params.valid?

    @pet.user_id = @user.id
    @pet = PetRepository.persist(@pet)
  end

  def upload_image!
    if image = @params.get('pet.image')
      filename = "pets/#{SecureRandom.hex}#{File.extname(image['tempfile'])}"

      client.put_object(
        bucket: ENV['AWS_BUCKET'],
        key: filename,
        body: File.open(image['tempfile']),
        acl: 'public-read'
      )
    end
    @pet.image_id = filename
    @pet = PetRepository.persist(@pet)
  end

  def client
    @client ||= Aws::S3::Client.new
  end

  def valid?
    @user && @params
  end
end
