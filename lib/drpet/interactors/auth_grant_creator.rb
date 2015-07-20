# class AuthGrantCreator
#   include Lotus::Interactor

#   def initialize(params)
#     @params = params
#   end

#   def call
#     # auth_grant = AuthGrantRepository.find_or_create_by_client_app_id_and_user_id(client_app.id, current_user.id)
#     # # TODO Ouch!
#     # redirect_to_url = client_app_params.get('redirect_uri')
#     # divisor = (redirect_to_url =~ /\?/) ? '&' : '?'
#     # redirect_to_url = "#{redirect_to_url}#{divisor}code=#{auth_grant.code}&response_type=code"

#     # redirect_to redirect_to_url
#   end

#   private

#   def valid?
#     @params.valid?
#   end
# end
