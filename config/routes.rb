Rails.application.routes.draw do
  resources :orders

  get 'carts/show'

  get 'store/index'

  mount RedactorRails::Engine => '/redactor_rails'
  devise_for :users
  root 'store#index'
  get 'dashboard'     =>  'store#dashboard'
  resources :categories
  resources :products
  resources :line_items
  resources :carts
end
