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
  resources :line_items, only: [:create, :destroy] do
    get 'increment', on: :member
    get 'decrement', on: :member
  end
  resources :carts, only: [:index, :show, :destroy]
end
