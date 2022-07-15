# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'products/shiftToRails', to: 'products#shiftToRails'
      resources :products
    end
  end
  namespace :api do
    namespace :v1 do
      get 'carts/getPrice', to: 'carts#getPrice'
      post 'carts/changeItem', to: 'carts#changeItem', as: 'changeItem'
      delete 'carts/destroy', to: 'carts#destroy'
      post 'carts/checkout', to: 'carts#checkout'
      resources :carts

    end
  end

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
  get 'success', to: 'checkout#success'
  resources :users do
    resources :products
  end
  resources :products do
    resources :comments
  end
  resources :comments
  resources :products do
    member do
      delete :delete_image_attachment
    end
  end
  scope :active_storage, module: :active_storage, as: :active_storage do
    resources :attachments, only: [:destroy]
  end
  authenticated do
    root to: 'secret#index', as: :authenticated_root
  end
end
