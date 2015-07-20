require 'json'

module Api::Controllers::Oauth
  class AccessToken
    include Api::Action

    params do
      param :app_id,     type: String, presence: true
      param :app_secret, type: String, presence: true
      param :code,       type: String, presence: true
    end

    accept :json

    def call(params)
      redirect_to '/' unless params.valid? # TODO: Create a page for error

      client_app = ClientAppRepository.authenticate(params.get('app_id'), params.get('app_secret'))

      if client_app && (auth_grant = AuthGrantRepository.find_by_client_app_id_and_code(client_app.id, params.get('code')))
        # TODO Move to serializer/presenter
        status 200, JSON.generate({
          access_token: auth_grant.access_token,
          refresh_token: auth_grant.refresh_token,
          expires_in: nil
        })
      else
        halt 401
      end
    end

    private

    def verify_csrf_token?
      false
    end
  end
end
