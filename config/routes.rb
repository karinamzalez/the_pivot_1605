Rails.application.routes.draw do
  resources :businesses, only: [:index, :show]
  resources :gnomes, only: [:index, :show]
  resources :businesses, only: [:index, :show]
  resources :farmers_markets, only: [:index, :show]
  resources :bucket_gnomes, only: [:create, :update, :destroy]
  resources :users, only: [:new, :show, :create]
  resources :orders, only: [:index, :create, :show]
  
  root to: 'businesses#index'
  get "users/verify", to: 'users#show_verify', as: 'verify'
  post "users/verify"
  post "users/resend"
  get '/', to: 'businesses#index'
  get '/bucket' => "bucket#show"
  put '/bucket' => "bucket#update"
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/dashboard', to: 'users#show'
  get '/:id' => 'categories#show'
  get "*any", via: :all, to: "errors#not_found"

  namespace :admin do
    get '/dashboard', to: 'users#show'

    resources :gnomes, except: [:destroy]
  end
end
