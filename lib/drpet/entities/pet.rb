class Pet
  include Lotus::Entity
  include Lotus::Validations

  attribute :name,       type: String,   presence: true
  attribute :user_id,    type: Integer,  presence: true
  attribute :created_at, type: DateTime
  attribute :updated_at, type: DateTime
end
