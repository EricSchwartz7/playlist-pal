Rails.application.routes.draw do
  root to: "api/v1/users#index"

  namespace :api do
    namespace :v1 do
      resources :users, only: [:index]
      get '/users/authorize_me', to: 'users#authorize_me'
      get '/users/authorized', to: 'users#authorized'
      get '/users/refresh', to: 'users#refresh'

      get '/tracks/hump_tracks', to: 'tracks#hump_tracks'
    end
  end
end
