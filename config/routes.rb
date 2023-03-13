Rails.application.routes.draw do
  root to: "api/v1/tracks#index"

  namespace :api do
    namespace :v1 do
      resources :tracks, only: [:index]
      get '/tracks/authorize_me', to: 'tracks#authorize_me'
      get '/tracks/authorized', to: 'tracks#authorized'
      get '/tracks/refresh', to: 'tracks#refresh'
      get '/tracks/hump_tracks', to: 'tracks#hump_tracks'
    end
  end
end
