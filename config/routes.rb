Rails.application.routes.draw do
  require 'sidekiq/web'

  mount Sidekiq::Web => '/sidekiq'

  root to: 'home#index'
  devise_for :users

  get 'dashboard', to: 'dashboard#index', as: :dashboard

  resources :users
  resources :user_imports, only: [:index, :new, :create]
end
