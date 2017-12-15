Rails.application.routes.draw do
  
  resources :spi_files
  resources :open_order_files
  resources :com40s
  resources :com40_files
  resources :orders
  resources :order_files
  resources :product_families
  resources :stock
  resources :stock_files
  resources :plans do
    member do
      get :generate
    end
  end
  resources :operations

  devise_for :users

  resources :products_import

  resources :elements do
    member do
      get :add_operation
    end
  end

  
  resources :products do
    member do
      get :add_element
    end

    collection do
      get :only_new
    end
  end
  resources :machines

  get 'home/index'

  get 'home/new'

  get 'home/create'

  get 'home/update'

  get 'home/index'
  root 'products#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
