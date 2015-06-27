require 'bcrypt'

class User
  include Lotus::Entity

  attributes :email, :password, :encrypted_password, :created_at, :updated_at

  def password
    @password ||= BCrypt::Password.new(encrypted_password)
  end

  def password=(password)
    @password = BCrypt::Password.create(password)
    self.encrypted_password = @password
  end
end
