Rails.application.routes.draw do
  get '/dashboard', to: 'dashboard#index'
  get '/history', to: 'dashboard#history'
  root 'static_pages#home'
  devise_for :users
  resources :currencies
  resources :budget
  resources :items, only: %i[create destroy]
  resources :transfer, only: %i[new create]
end
