Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  resources :home, only: [:index]
  resources :products, only: %i[index show]
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
