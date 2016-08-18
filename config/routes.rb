Rails.application.routes.draw do
  root to: 'businesses#index'

  get "users/verify", to: 'users#show_verify', as: 'verify'
  post "users/verify"
  post "users/resend"

  resources :businesses, only: [:index]
  resources :farmers_markets, only: [:index, :show]

  resources :bucket_gnomes, only: [:create, :update, :destroy]
  resources :users, only: [:new, :show, :create]
  resources :orders, only: [:index, :create, :show]

  get '/bucket' => "bucket#show"
  put '/bucket' => "bucket#update"

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/dashboard', to: 'users#show'

  get ':business_slug', to: 'businesses#show', as: :business

  namespace :admin do
    get '/dashboard', to: 'users#show'

    resources :gnomes, except: [:destroy]
  end

  get '/:id' => 'categories#show'
  get "*any", via: :all, to: "errors#not_found"
end
