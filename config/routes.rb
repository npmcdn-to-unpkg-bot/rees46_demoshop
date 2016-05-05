Rails.application.routes.draw do
  resources :orders

  get 'store/index'
  get 'store/font_products_urls'
  post 'store/font_products_urls' => 'store#font_products_urls'

  mount RedactorRails::Engine => '/redactor_rails'
  devise_for :users
  root 'store#index'
  get 'dashboard' => 'store#dashboard'

  resources :categories do
    post 'cat_urls' => 'categories#cat_urls'
  end
  post 'categories/cat_urls' => 'categories#cat_urls'

  resources :brands

  resources :products do
    post 'products_urls' => 'products#products_urls'
    collection { post :import }
  end
  post 'products/products_urls' => 'products#products_urls'

  resources :line_items, only: [:create, :destroy] do
    get 'increment', on: :member
    get 'decrement', on: :member
  end

  resources :carts, only: [:index, :show, :destroy] do
    post 'cart_urls' => 'carts#cart_urls'
  end
  post 'carts/cart_urls' => 'carts#cart_urls'

  resources :parsers, only: :index
  get 'store/xml_rees46'
end
