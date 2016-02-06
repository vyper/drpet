class CreatePetParams < Hanami::Action::Params
  param :pet do
    param :name, presence: true
    param :image
  end
end

class UpdatePetParams < Hanami::Action::Params
  param :id
  param :pet do
    param :name, presence: true
    param :image
  end
end
