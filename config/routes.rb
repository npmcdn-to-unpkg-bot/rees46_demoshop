Rails.application.routes.draw do
  resources :orders

  get 'store/index'

  mount RedactorRails::Engine => '/redactor_rails'
  devise_for :users
  root 'store#index'
  get 'dashboard'     =>  'store#dashboard'
  resources :categories
  resources :products
  resources :line_items, only: :create
  resources :carts, only: [:idex, :show, :destroy]
end
