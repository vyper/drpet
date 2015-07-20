class ClientApp
  include Lotus::Entity
  include Lotus::Validations

  attribute :name,         type: String,   presence: true
  attribute :app_id,       type: String,   presence: true
  attribute :app_secret,   type: String,   presence: true
  attribute :permissions,  type: String,   presence: true
  attribute :user_id,      type: Integer,  presence: true
  attribute :redirect_uri, type: String,   presence: true, format: URI::regexp
  attribute :created_at,   type: DateTime
  attribute :updated_at,   type: DateTime
end
