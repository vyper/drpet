# TODO DRY, duplicated in apps/web ):
module Api
  module Controllers
    module Authenticable
      def self.included(action)
        action.class_eval do
          expose :current_user
          expose :logged_user?
        end
      end

      private

      def authenticate!
        unless authenticated?
          session[:redirect_to] = request.env['REQUEST_URI'] if request.env['REQUEST_URI']
          # TODO: Correct way to access routes in other app?
          redirect_to '/login'
        end
      end

      def logged_user?
        authenticated?
      end

      def authenticated?
        !!current_user
      end

      def current_user
        @current_user ||= UserRepository.find(session['logged_user_id'])
      end
    end
  end
end
