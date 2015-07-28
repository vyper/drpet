class CreatePetParams < Lotus::Action::Params
  param :pet do
    param :name, presence: true
    param :image
  end
end

class UpdatePetParams < Lotus::Action::Params
  param :id
  param :pet do
    param :name, presence: true
    param :image
  end
end
