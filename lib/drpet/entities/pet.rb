class Pet
  include Lotus::Entity
  include Lotus::Validations

  attribute :name, presence: true
  attributes :created_at, :updated_at
end
