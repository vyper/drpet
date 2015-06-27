# Configure your routes here
# See: http://www.rubydoc.info/gems/lotus-router/#Usage
get    '/',       to: 'pets#index',            as: :root

get    '/login',  to: 'user_sessions#new',     as: :new_session
post   '/login',  to: 'user_sessions#create',  as: :create_session
delete '/logout', to: 'user_sessions#destroy', as: :destroy_session
