Rails.application.routes.draw do
  resources :line_items
  resources :carts
  get 'comments/index'
  get 'comments/show'
  get 'products/index'
  get 'products/show'
  get 'users/index'
  get 'users/show'
  devise_for :users
  # devise_for :users
  # resources :users, only: %i[show]
  root 'products#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :webhooks, only: [:create]
  resources :checkout, only: [:create]

  resources :users do
    resources :products
  end
  resources :products do
    resources :comments
  end
  resources :comments
end
