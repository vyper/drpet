class ClientAppRepository
  include Hanami::Repository

  def self.find_by_app_id(app_id)
    query do
      where(app_id: app_id)
    end.first
  end

  def self.authenticate(app_id, app_secret)
    query do
      where(app_id: app_id, app_secret: app_secret)
    end.first
  end
end
