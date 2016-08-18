Rails.application.routes.draw do
  root to: 'businesses#index'

  resources :items
  resources :businesses, only: [:index]
  resources :cart_items, only: [:create, :update, :destroy]
  resources :users, only: [:new, :show, :create]
  resources :orders, only: [:index, :create, :show]

  get '/cart' => "cart#show"
  put '/cart' => "cart#update"

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/dashboard', to: 'users#show'

  namespace :admin do
    get '/dashboard', to: 'users#show'

    resources :items, except: [:destroy]
  end

  get '/category/:id' => 'categories#show', as: :category
  get '/:business_slug', to: 'businesses#show', as: :business
  get "*any", via: :all, to: "errors#not_found"
end
