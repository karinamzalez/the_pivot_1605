Rails.application.routes.draw do
  root to: 'businesses#index'

  namespace :admin do
    resources :items, only: [:update, :edit, :destroy, :create, :new]
  end

  resources :items
  resources :businesses, only: [:index, :new, :create, :edit]
  patch '/businesses/:id', to: 'businesses#update', as: :business
  delete '/businesses/:id', to: 'businesses#destroy'
  resources :cart_items, only: [:create, :update, :destroy]
  resources :users, only: [:new, :create, :edit, :update]
  resources :orders, only: [:index, :create, :show]
  resources :categories, only: [:show]
  resources :business_admins, only: [:new, :create, :show, :edit, :update, :destroy]

  get '/cart' => "cart#show"
  put '/cart' => "cart#update"

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/dashboard', to: 'users#show'

  get '/:business_slug', to: 'businesses#show', as: :business_slug

  get '/auth/:provider/callback', to: 'sessions#create'

  get "*any", via: :all, to: "errors#not_found"
end
