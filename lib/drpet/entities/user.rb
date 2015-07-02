require 'bcrypt'

class User
  include Lotus::Entity
  include Lotus::Validations

  # TODO Improve regex
  REGEX_EMAIL = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/

  attribute :email,    presence: true, format: REGEX_EMAIL
  attribute :password, presence: true
  attributes :uid, :encrypted_password, :created_at, :updated_at

  def password
    unless @encrypted_password.nil?
      @password ||= BCrypt::Password.new(encrypted_password)
    end
  end

  def password=(password)
    if password.nil? || password.empty?
      @password = nil
      @encrypted_password = nil
    else
      @password = BCrypt::Password.create(password)
      @encrypted_password = @password
    end
  end
end
