Rails.application.routes.draw do
  get 'favorites/uptade'
  devise_for :users
  root to: 'itineraries#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :itineraries, only: %i[index show new create] do
    resources :sites, only: %i[new create destroy]
    resources :favorites, only: %i[create]
  end
  resources :favorites, only: %i[destroy]
  resources :users, only: %i[show]
end
