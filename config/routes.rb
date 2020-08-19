Rails.application.routes.draw do
  resources :users, only: [:index, :show]
  get '/user/projects/:id', to: 'users#user_project'
  # patch 'user/:id', to: 'users#update'
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
