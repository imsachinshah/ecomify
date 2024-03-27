Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :users 
  
  # Defines the root path route ("/")
  # root "posts#index"
  post 'users/verify_user'
  get 'users/resend_otp', to: 'users#resend_otp'
  post '/login', to: 'authentication#login'

  resources :categories, :products
  resources :reviews, only: [:create, :update, :index]
  resources :carts, only: [:show] do
    collection do
      post 'add_item', to: 'carts#add_item'
      delete 'remove_item/:id', to: 'carts#remove_item'
    end
  end
  resources :line_items, only: [:create, :destroy]
end
