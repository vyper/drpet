module Web
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
        redirect_to routes.new_user_session_path unless authenticated?
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
