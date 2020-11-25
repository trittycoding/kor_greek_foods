Rails.application.routes.draw do
  resources :pages, except: [:show]
  get '/pages/:permalink' => 'pages#permalink', as: :permalink
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  resources :home, only: [:index]
  resources :products, only: %i[index show] do
    collection do
      get 'search'
    end
  end
  resources :categories, only: %i[index show]
  resources :orders, only: %i[index show]

  ActiveAdmin.routes(self)
  get 'users/index'
  get 'users/show'
  get 'products/index'
  get 'products/show'
  get 'categories/index'
  get 'categories/show'
  get 'orders/index'
  get 'orders/show'
  get 'order/index'
  get 'order/show'

  # Rerouting default path to home controller
  root to: 'home#index'
end
