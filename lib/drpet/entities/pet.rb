class Pet
  include Lotus::Entity
  include Lotus::Validations

  attribute :name,       type: String,   presence: true
  attribute :user_id,    type: Integer,  presence: true
  attribute :image,      type: String # TODO Remove this useless field );
  attribute :image_id,   type: String
  attribute :created_at, type: DateTime
  attribute :updated_at, type: DateTime
end
