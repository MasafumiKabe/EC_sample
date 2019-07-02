Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  get 'toppages/index'

  root to: 'toppages#index'

  get 'users/:id/cart', to: 'users#cart', as: 'cart'
  resources :users, only: [:show]

  resources :items, only: [:show, :new]
  resources :ownerships, only: [:create, :destroy]
  
end
