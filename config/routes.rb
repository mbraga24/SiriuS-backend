Rails.application.routes.draw do
  resources :users, only: [:index, :show]
  post '/signup', to: 'users#create'
  post '/login', to: 'users#login'
  get '/autologin/:id', to: 'users#autologin'
  get '/admin/:id', to: 'users#admin'

  # patch 'users/:id', to: 'users#update'
  # get 'users/:id', to: 'users#show'
  # get '/users', to: 'users#index'
  
  # get '/user/projects/:id', to: 'users#user_project' <=== ??

  resources :projects, only: [:index, :create, :show]
  # get '/projects', to: 'projects#index'
  # get '/show/:id', to: 'projects#show'
  # post '/projects', to: 'projects#create'

  # resources :admins , only: [:index, :show]
  # get '/admins/account/:id', to: 'admins#show'
end
