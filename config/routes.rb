Rails.application.routes.draw do
  #get 'favorites/uptade'
  get 'itineraries/:id/edit', to: 'itineraries#edit', as: 'edit_itinerary'
  devise_for :users
  root to: 'itineraries#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :itineraries, only: %i[index show new create edit update destroy] do
    resources :sites, only: %i[new create destroy edit update]
    resources :favorites, only: %i[create]
  end
  resources :favorites, only: %i[destroy]
  resources :users, only: %i[show]
end
