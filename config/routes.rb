Rails.application.routes.draw do
  root :to => 'welcomes#index'
  resources :orders, only: %i[create index update] do
    member do
      get :customer_orders
    end
  end
  resources :welcomes, only: %i[index]
  resources :user_addresses, only: %i[create update]
  resources :user_leads, only: %i[index create update] do
    collection do
      post :add_lead
      get :report
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # post 'authenticate', to: 'authentication#authenticate'
  resources :users, only: [:update] do
    collection do
      post :register
      post :login
      post :change_password
      post :reset_password
      get :user_exist
      get :current_user
    end
  end
end
