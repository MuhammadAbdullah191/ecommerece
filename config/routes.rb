Rails.application.routes.draw do
  get 'comments/index'
  get 'comments/show'
  get 'products/index'
  get 'products/show'
  get 'users/index'
  get 'users/show'
  devise_for :users
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
    resources :products
  end
  resources :products do
    resources :comments
  end
end
