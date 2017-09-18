Rails.application.routes.draw do
  resources :stock
  resources :stock_files

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
