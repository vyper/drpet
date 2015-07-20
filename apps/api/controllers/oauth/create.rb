module Api::Controllers::Oauth
  class Create
    include Api::Action

    before :authenticate!

    params do
      param :client_app do
        param :app_id,       type: String, presence: true
        param :permissions,  type: Array,  presence: true
      end
    end

    def call(params)
      redirect_to '/' unless params.valid? # TODO: Create a page for error

      client_app = ClientAppRepository.find_by_app_id(client_app_params.get('app_id'))
      redirect_to '/' unless client_app # TODO: Create a page for error

      auth_grant = AuthGrantRepository.find_or_create_by_client_app_id_and_user_id(client_app.id, current_user.id)
      # TODO Ouch! Move to the interactor, please!
      redirect_to_url = client_app.redirect_uri
      divisor = (redirect_to_url =~ /\?/) ? '&' : '?'
      redirect_to_url = "#{redirect_to_url}#{divisor}code=#{auth_grant.code}&response_type=code"

      redirect_to redirect_to_url
    end

    private

    def client_app_params
      params.get('client_app')
    end
  end
end
