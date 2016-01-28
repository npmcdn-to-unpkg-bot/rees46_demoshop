Rails.application.routes.draw do
  get 'store/index'

  mount RedactorRails::Engine => '/redactor_rails'
  devise_for :users
  root 'welcomes#index'
  get 'dashboard'     =>  'welcomes#dashboard'
  resources :categories
  resources :products
end
