class PetRepository
  include Lotus::Repository

  def self.all_owned_by(user)
    query do
      where(user_id: user.id)
    end
  end
end
