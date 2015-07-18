class ClientAppRepository
  include Lotus::Repository

  def self.find_by_app_id(app_id)
    query do
      where(app_id: app_id)
    end.first
  end
end
