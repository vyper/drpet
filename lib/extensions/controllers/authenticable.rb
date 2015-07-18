module Extensions
  module Controllers
    module Authenticable
      def self.included(action)
        action.class_eval do
          expose :current_user
          expose :logged_user?
        end
      end

      private

      def sign_in_and_redirect(user)
        session[:logged_user_id] = user.id
        flash[:notice] = 'Signed in successfully' # TODO i18n?
        redirect_to_url = session.delete('redirect_to')
        # TODO: Correct way to access routes in other app?
        redirect_to redirect_to_url || '/'
      end

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
