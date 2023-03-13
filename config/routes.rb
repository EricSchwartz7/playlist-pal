Rails.application.routes.draw do
  root to: "api/v1/tracks#index"

  namespace :api do
    namespace :v1 do
      resources :tracks, only: [:index]
    end
  end
end
