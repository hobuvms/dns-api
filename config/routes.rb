Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'authenticate', to: 'authentication#authenticate'
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
