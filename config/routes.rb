Rails.application.routes.draw do
  devise_for :users
  root 'welcomes#index'
  get 'dashboard'     =>  'welcomes#dashboard'
  resources :categories
  resources :products
end
