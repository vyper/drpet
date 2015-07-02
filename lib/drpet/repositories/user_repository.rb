class UserRepository
  include Lotus::Repository

  def self.find_by_email(email)
    query do
      where(email: email)
    end.first
  end

  def self.find_by_uid(uid)
    query do
      where(uid: uid)
    end.first
  end

  def self.find_or_create_from_omniauth(auth)
    uid   = auth['uid']
    email = auth['info']['email']

    user = find_by_uid(uid)

    if !user
      if user = find_by_email(email)
        user.uid = uid
        user = persist(user)
      else
        user = create(User.new(uid: uid, email: email, password: SecureRandom.hex))
      end
    end

    user
  end
end
