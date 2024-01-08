Rails.application.routes.draw do
  namespace :admin do
    resources :users
    #resources :currencies

    root to: "users#index"
  end

  get '/dashboard', to: 'dashboard#index'
  get '/budget_menu', to: 'dashboard#budgets'
  get '/history', to: 'dashboard#history'
  root 'dashboard#index'

  devise_for :users
  resources :currencies
  resources :budgets do
    resources :items, only: %i[create destroy]
  end

  resources :transfer, only: %i[new create]
end
