class AuthGrant
  include Hanami::Entity
  include Hanami::Validations

  attribute :code,          type: String,  presence: true
  attribute :access_token,  type: String,  presence: true
  attribute :refresh_token, type: String,  presence: true
  attribute :permissions,   type: String,  presence: true
  attribute :client_app_id, type: Integer, presence: true
  attribute :user_id,       type: Integer, presence: true
  attribute :created_at,    type: DateTime
  attribute :updated_at,    type: DateTime
end
