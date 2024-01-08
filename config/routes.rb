Rails.application.routes.draw do
  get '/dashboard', to: 'dashboard#index'
  get '/budget_menu', to: 'dashboard#budgets'
  get '/history', to: 'dashboard#history'
  root 'static_pages#home'
  devise_for :users
  resources :currencies
  resources :budgets do
    resources :items, only: %i[create destroy]
  end
  resources :transfer, only: %i[new create]
end
