Rails.application.routes.draw do
  resources :orders

  get 'store/index'
  post 'store/store_recommender' => 'store#store_recommender'

  mount RedactorRails::Engine => '/redactor_rails'
  devise_for :users
  root 'store#index'
  get 'dashboard' => 'store#dashboard'

  post 'recommendations' => 'recommendations#rees46_recommender'

  resources :categories do
    post 'categories_recommender' => 'categories#categories_recommender'
  end
  post 'categories/categories_recommender' => 'categories#categories_recommender'

  resources :brands

  resources :products do
    post 'recommended_by=' => 'recommendations#rees46_recommender', on: :collection
    collection { post :import }
  end

  resources :line_items, only: [:create, :destroy] do
    get 'increment', on: :member
    get 'decrement', on: :member
  end

  resources :carts, only: [:index, :show, :destroy] do
    post 'cart_recommender' => 'carts#cart_recommender'
  end
  post 'carts/cart_recommender' => 'carts#cart_recommender'

  resources :parsers, only: :index
  get 'store/xml_rees46'
end
