module Api::Controllers::Oauth
  class New
    include Api::Action

    before :authenticate!

    # TODO Move this to class. (:
    params do
      param :client_id,    type: String, presence: true
      param :redirect_uri, type: String, presence: true
    end

    expose :client_app
    expose :redirect_uri
    expose :permissions

    def call(params)
      redirect_to '/' unless params.valid? # TODO: Create a page for error

      @client_app = ClientAppRepository.find_by_app_id(params[:client_id])
      redirect_to '/' unless @client_app # TODO: Create a page for error

      @redirect_uri = params[:redirect_uri]
    end
  end
end
