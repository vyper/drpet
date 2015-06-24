collection :pets do
  entity     Pet
  repository PetRepository

  attribute :id,         Integer
  attribute :name,       String
  attribute :created_at, DateTime
  attribute :updated_at, DateTime
end
