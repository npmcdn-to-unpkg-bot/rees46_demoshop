Rails.application.routes.draw do
  devise_for :users
  root 'welcomes#index'
  get 'dashboard'     =>  'welcomes#dashboard'
end
