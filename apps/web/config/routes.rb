# Configure your routes here
# See: http://www.rubydoc.info/gems/lotus-router/#Usage
get    '/', to: 'pets#index',            as: :root

get    '/login',  to: 'user_sessions#new',      as: :new_user_session
post   '/login',  to: 'user_sessions#create',   as: :user_session
delete '/logout', to: 'user_sessions#destroy',  as: :destroy_user_session

# TODO: In the future we can support others
get '/auth/failure',           to: 'user_sessions#failure',  as: :auth_failure
get '/auth/facebook/callback', to: 'user_sessions#facebook', as: :auth_facebook_callback

resources :pets, only: [:index, :new, :create]
