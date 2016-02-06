require 'bcrypt'

class User
  include Hanami::Entity
  include Hanami::Validations

  # TODO Improve regex
  REGEX_EMAIL = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/

  attribute :email,      type: String, presence: true, format: REGEX_EMAIL
  attribute :password,   type: String, presence: true
  attribute :uid,        type: String
  attribute :created_at, type: DateTime
  attribute :updated_at, type: DateTime
  attributes :encrypted_password # TODO: do we need use coercion here?

  def password
    unless @encrypted_password.nil?
      @password ||= BCrypt::Password.new(encrypted_password)
    end
  end

  def password=(password)
    if password.nil? || password.to_s.empty?
      @password = nil
      @encrypted_password = nil
    else
      @password = BCrypt::Password.create(password)
      @encrypted_password = @password
    end
  end
end
