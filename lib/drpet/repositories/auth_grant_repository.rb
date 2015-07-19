class AuthGrantRepository
  include Lotus::Repository

  def self.find_or_create_by_client_app_id_and_user_id(client_app_id, user_id)
    client_app = find_by_app_id_and_user_id(client_app_id, user_id)

    if !client_app
      attributes = {
        code: unique_token_for_code,
        access_token: unique_token_for_access_token,
        refresh_token: unique_token_for_refresh_token,
        permissions: '', # TODO Search about this field d:
        user_id: user_id,
        client_app_id: client_app_id,
      }
      client_app = create(AuthGrant.new(attributes))
    end

    client_app
  end

  def self.find_by_app_id_and_user_id(client_app_id, user_id)
    query do
      where(client_app_id: client_app_id, user_id: user_id)
    end.first
  end

  def self.unique_token_for(attribute, secure_token = SecureRandom.hex)
    token = query { where(attribute => secure_token) }.first

    if token
      unique_token_for(attribute)
    else
      secure_token
    end
  end

  def self.unique_token_for_code
    unique_token_for(:code)
  end

  def self.unique_token_for_access_token
    unique_token_for(:access_token)
  end

  def self.unique_token_for_refresh_token
    unique_token_for(:refresh_token)
  end

  def self.find_by_client_app_id_and_code(client_app_id, code)
    query do
      where(client_app_id: client_app_id, code: code)
    end.first
  end

  def self.find_by_access_token(access_token)
    query do
      where(access_token: access_token)
    end.first
  end
end
