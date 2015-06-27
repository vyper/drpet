class UserRepository
  include Lotus::Repository

  def self.find_by_email(email)
    query do
      where(email: email)
    end.first
  end
end
