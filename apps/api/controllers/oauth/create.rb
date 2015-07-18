module Api::Controllers::Oauth
  class Create
    include Api::Action

    before :authenticate!

    params do
      param :client_app do
        param :app_id,       type: String, presence: true
        param :redirect_uri, type: String, presence: true
        param :permissions,  type: Array,  presence: true
      end
    end

    def call(params)
      byebug
      redirect_to '/' unless params.valid? # TODO: Create a page for error

      @client_app = ClientAppRepository.find_by_app_id(params[:client_id])
      redirect_to '/' unless @client_app # TODO: Create a page for error
    end
  end
end
