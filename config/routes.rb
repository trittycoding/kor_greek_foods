Rails.application.routes.draw do
  get '/pages/send_mail' => 'pages#send_mail', as: :send_mail
  resources :pages, except: [:show]
  get '/pages/:permalink' => 'pages#permalink', as: :permalink
  devise_for :users
  resources :users, except: [:edit]
  get '/users/:email/edit' => 'users#edit_account', as: :edit_account
  post 'users/:email/edit' => 'users#post_account_changes', as: :post_account_changes
  devise_for :admin_users, ActiveAdmin::Devise.config
  resources :home, only: [:index]
  resources :products, only: %i[index show] do
    collection do
      get 'search'
    end
  end
  resources :categories, only: %i[index show]
  resources :orders, except: %i[show]
  get '/orders/user_orders' => 'orders#user_orders', as: :user_orders
  resources :cart, only: %i[create destroy show adjust_quantity]
  get '/cart/show' => 'cart#show', as: :cart_show
  post '/cart/adjust_quantity/' => 'cart#adjust_quantity', as: :adjust_quantity

  scope '/checkout' do
    post 'create', to: 'checkout#create', as: 'checkout_create'
    get 'success', to: 'checkout#success', as: 'checkout_success'
    get 'cancel', to: 'checkout#cancel', as: 'checkout_cancel'
  end

  ActiveAdmin.routes(self)
  get 'users/index'
  get 'users/show'
  get 'users/edit'
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
