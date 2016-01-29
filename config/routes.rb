Rails.application.routes.draw do
  get 'orders/index'
  get 'orders/new'
  get 'orders/create'

  get 'carts/show'

  get 'store/index'

  mount RedactorRails::Engine => '/redactor_rails'
  devise_for :users
  root 'store#index'
  get 'dashboard'     =>  'welcomes#dashboard'
  resources :categories
  resources :products
  resources :line_items
  resources :carts
end
