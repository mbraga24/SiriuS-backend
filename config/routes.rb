Rails.application.routes.draw do
  resources :users, only: [:index, :show]
  post '/signup', to: 'users#create'
  post '/login', to: 'users#login'
  get '/autologin/:id', to: 'users#autologin'
  get '/admin/:id', to: 'users#admin'

  # patch 'users/:id', to: 'users#update'
  # get 'users/:id', to: 'users#show'
  # get '/users', to: 'users#index'

  resources :projects, only: [:index, :create, :show]
  delete '/projects/clear', to: 'projects#delete_all_complete'
  patch '/project/complete/:id', to: 'projects#complete'
  # get '/projects', to: 'projects#index'
  # get '/show/:id', to: 'projects#show'
  # post '/projects', to: 'projects#create'
  # delete '/projects', to: 'projects#delete_all_complete'

end
