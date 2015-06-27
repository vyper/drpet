collection :pets do
  entity     Pet
  repository PetRepository

  attribute :id,         Integer
  attribute :name,       String
  attribute :created_at, DateTime
  attribute :updated_at, DateTime
end

collection :users do
  entity     User
  repository UserRepository

  attribute :id,                 Integer
  attribute :email,              String
  attribute :encrypted_password, String
  attribute :created_at,         DateTime
  attribute :updated_at,         DateTime
end
