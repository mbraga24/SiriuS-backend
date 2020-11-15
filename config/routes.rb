Rails.application.routes.draw do
  resources :users, only: [:index, :show, :destroy]
  resources :invites 
  resources :arquive_projects, only: [:index, :show, :create, :destroy]
  
  post '/signup', to: 'users#create'
  post '/login', to: 'users#login'
  get '/autologin/:id', to: 'users#autologin'
  delete 'users/:user_id/remove-project/:project_id', to: 'users#remove_project'

  resources :projects, only: [:index, :create, :show, :destroy]
  get '/download/:id', to: 'projects#download_zip'
  patch '/add_user/project', to: 'projects#add_users_to_project'

  resources :documents, only: [:index, :create]
end
