Rails.application.routes.draw do
  resources :orders

  mount RedactorRails::Engine => '/redactor_rails'
  devise_for :users
  root 'store#index'

  get 'dashboard' => 'store#dashboard'

  get 'recommendations' => 'recommendations#rees46_recommender'

  resources :categories

  resources :brands

  resources :products do
    collection { post :import }
  end

  resources :line_items, only: [:create, :destroy] do
    get 'increment', on: :member
    get 'decrement', on: :member
  end

  resources :carts, only: [:index, :show, :destroy]

  resources :parsers, only: :index
  get 'store/xml_rees46'
end
