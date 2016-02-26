Rails.application.routes.draw do
  resources :orders

  get 'store/index'

  mount RedactorRails::Engine => '/redactor_rails'
  devise_for :users
  root 'store#index'
  get 'dashboard' => 'store#dashboard'
  resources :categories
  resources :brands
  resources :products
  resources :line_items, only: :create do
    patch 'increment', on: :member
    patch 'decrement', on: :member
  end
  resources :carts, only: [:idex, :show, :destroy]
end
