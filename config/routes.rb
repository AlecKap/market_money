Rails.application.routes.draw do
  namespace :api do
    namespace :v0 do
      resources :vendors, only: %i[show create update destroy]
      resources :market_vendors, only: [:create]
      resource :market_vendors, only: [:destroy]
      namespace :markets do
        resource :search, only: [:show]
      end
      resources :markets, only: %i[index show] do
        resources :vendors, only: [:index], controller: 'markets/vendors'
      end
    end
  end
end
