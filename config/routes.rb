Rails.application.routes.draw do
  resources :order_items
  resources :orders
  resources :line_items
  resources :carts
  devise_for :users
  # devise_for :users
  # resources :users, only: %i[show]
  root 'products#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :webhook, only: [:create]
  resources :checkout, only: [:create]
  get "success", to: "checkout#success"
  resources :users do
    resources :products
  end
  resources :products do
    resources :comments
  end
  resources :comments
end
