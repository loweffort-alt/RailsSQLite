Rails.application.routes.draw do
  #get 'api/index'
  root 'home#index'
  #resources :api, only: [:index]
  namespace :api do
    resources :features, only: [:index, :show] do
      resources :comments, only: [:index, :create, :destroy]
    end
  end
end
