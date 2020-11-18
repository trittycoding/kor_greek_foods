Rails.application.routes.draw do
  get 'users/index'
  get 'users/show'
  get 'products/index'
  get 'products/show'
  get 'customer_provinces/index'
  get 'categories/index'
  get 'categories/show'
  get 'orders/index'
  get 'orders/show'
  get 'order/index'
  get 'order/show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
