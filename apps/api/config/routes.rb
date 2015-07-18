# Configure your routes here
# See: http://www.rubydoc.info/gems/lotus-router/#Usage
namespace :v1 do
  resources :pets, only: :index
end

get  '/oauth/new',       to: 'oauth#new',    as: :oauth_new
post '/oauth/authorize', to: 'oauth#create', as: :oauth_authorize
# post '/oauth/token',     to: 'oauth#token',  as: :oauth_token
