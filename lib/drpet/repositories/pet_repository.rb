class PetRepository
  include Lotus::Repository

  def self.owned_by(user)
    query do
      where(user_id: user.id)
    end
  end

  def self.find_owned_by(id, user)
    query do
      where(user_id: user.id, id: id)
    end.first
  end
end
