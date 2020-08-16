Rails.application.routes.draw do
  resources :users, only: [:index, :show]
  # get 'users/:id', to: 'users#show'
  # get '/users', to: 'users#index'

  resources :projects, only: [:index, :create]
  # get '/projects', to: 'projects#index'
  # post '/projects', to: 'projects#create'

  resources :admins , only: [:index, :show]
  # get '/admins/account/:id', to: 'admins#show'
  post '/signup', to: 'admins#create'
  post '/login', to: 'admins#login'
  get '/autologin/:id', to: 'admins#autologin'
end
