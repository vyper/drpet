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

  private

  def valid?
    @user && @params
  end
end
