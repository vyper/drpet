require 'hanami/interactor'

class PetPersistor
  include Hanami::Interactor

  expose :params, :user, :pet

  def initialize(params, user)
    @params = params
    @user   = user
    @pet    = Pet.new(params.get('pet'))
  end

  def call
    find!
    upload_image_to_cache!
    persist!
    move_image_to_store!
  end

  private

  def find!
    if @params.get('id')
      @pet = PetRepository.find_owned_by(@params.get('id'), @user)
      error! 'Pet not found' unless @pet
    else
      @pet = Pet.new @params.get('pet')
    end

    @pet.update @params.get('pet')

    error! 'Invalid params' unless @params.valid?
  end

  def persist!
    @pet.user_id = @user.id

    if @pet.changed_attributes.keys.include?(:image_id) && !@pet.changed_attributes[:image_id].empty?
      client.delete_object bucket: ENV['AWS_BUCKET'], key: "store/pets/#{@pet.changed_attributes[:image_id]}"
    end

    @pet = PetRepository.persist(@pet)
  end

  def upload_image_to_cache!
    if image = @params.get('pet.image')
      @pet.image_id = "#{SecureRandom.hex}#{File.extname(image['tempfile'])}"

      client.put_object(
        bucket: ENV['AWS_BUCKET'],
        key: "cache/pets/#{@pet.image_id}",
        body: File.open(image['tempfile']),
        acl: 'public-read'
      )
    end
  end

  def move_image_to_store!
    if not @pet.image_id.empty?
      cache_key = "cache/pets/#{@pet.image_id}"
      store_key = "store/pets/#{@pet.image_id}"

      client.copy_object bucket: ENV['AWS_BUCKET'], copy_source: "#{ENV['AWS_BUCKET']}/#{cache_key}", key: store_key, acl: 'public-read'
      client.delete_object bucket: ENV['AWS_BUCKET'], key: cache_key
    end
  end

  def client
    @client ||= Aws::S3::Client.new
  end

  def valid?
    @user && @params
  end
end
