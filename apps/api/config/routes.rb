# Configure your routes here
# See: http://www.rubydoc.info/gems/lotus-router/#Usage
namespace :api do
  namespace :v1 do
    resources :pets, only: :index
  end
end
