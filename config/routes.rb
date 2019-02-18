# frozen_string_literal: true

Rails.application.routes.draw do
  resources :calendar_events, only: [:index]
  post 'auth/register', to: 'users#register'
  post 'auth/login', to: 'users#login'
  get 'test', to: 'users#test'

  resources :listing_attributes, only: [:index]
  resources :categories, only: [:index] do
    collection do
      get :details
    end
  end
  resources :listings, only: %i[create index] do
    collection do
      put :update_event
    end
  end
  resources :invitations
  resources :dns_point_logs
  resources :images, only: [:create]
  resources :users, only: [:update] do
    collection do
      post :register
      post :change_password
      post :reset_password
      get :user_exist
      get :current_user
    end
  end
  namespace :v1 do
    resources :orders, only: %i[index create]
  end
end
