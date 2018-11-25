Rails.application.routes.draw do
  root 'orderings#index'
  get 'sign_up', to: 'sign_up#new'
  post 'sign_up', to: 'sign_up#create'
  # get 'orderings', to: "ordering#index"
  # post 'orderings/order'
  get 'login', to: "login#new"
  post 'login', to: "login#create"
  delete 'logout', to: "login#destroy"
  
  resources :payments, only:[:new, :create]
  resources :orders
  resources :users
  resources :menu_items
  resources :categories
  resources :orderings, only: [:index] do
    collection do
      post 'order'
      get 'checkout'
      post 'update_order'
    end
    
    member do
      delete 'decrease_quantity'
      put 'increase_quantity'
    end
    
  end
  
  namespace :api do
    resources :menu_items
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
