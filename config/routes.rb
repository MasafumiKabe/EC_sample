Rails.application.routes.draw do
  devise_for :users
  get 'toppages/index'

  root to: 'toppages#index'
  resources :users, only: [:show]

  resources :items, only: [:new]
end
