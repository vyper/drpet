collection :auth_grants do
  entity     AuthGrant
  repository AuthGrantRepository

  attribute :id,            Integer
  attribute :code,          String
  attribute :access_token,  String
  attribute :refresh_token, String
  attribute :permissions,   String
  attribute :client_app_id, Integer
  attribute :user_id,       Integer
  attribute :created_at,    DateTime
  attribute :updated_at,    DateTime
end

collection :client_apps do
  entity     ClientApp
  repository ClientAppRepository

  attribute :id,           Integer
  attribute :name,         String
  attribute :app_id,       String
  attribute :app_secret,   String
  attribute :permissions,  String
  attribute :redirect_uri, String
  attribute :user_id,      Integer
  attribute :created_at,   DateTime
  attribute :updated_at,   DateTime
end

collection :pets do
  entity     Pet
  repository PetRepository

  attribute :id,         Integer
  attribute :user_id,    Integer
  attribute :name,       String
  attribute :created_at, DateTime
  attribute :updated_at, DateTime
end

collection :users do
  entity     User
  repository UserRepository

  attribute :id,                 Integer
  attribute :uid,                String
  attribute :email,              String
  attribute :encrypted_password, String
  attribute :created_at,         DateTime
  attribute :updated_at,         DateTime
end
