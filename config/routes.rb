Rails.application.routes.draw do
  resources :orders

  get 'store/index'

  get 'recommended_by=' => 'recommendations#rees46_recommender'

  mount RedactorRails::Engine => '/redactor_rails'
  devise_for :users
  root 'store#index'

  get 'dashboard' => 'store#dashboard'

  get 'recommendations' => 'recommendations#rees46_recommender'

  resources :categories do
    get 'recommended_by=' => 'recommendations#rees46_recommender', on: :collection
  end

  resources :brands

  resources :products do
    get 'recommended_by=' => 'recommendations#rees46_recommender', on: :collection
    collection { post :import }
  end

  resources :line_items, only: [:create, :destroy] do
    get 'increment', on: :member
    get 'decrement', on: :member
  end

  resources :carts, only: [:index, :show, :destroy] do
    get 'recommended_by=' => 'recommendations#rees46_recommender', on: :collection
  end

  resources :parsers, only: :index
  get 'store/xml_rees46'
end
