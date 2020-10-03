Rails.application.routes.draw do
  resources :users, only: [:index, :show, :destroy]
  post '/signup', to: 'users#create'
  post '/login', to: 'users#login'
  get '/autologin/:id', to: 'users#autologin'
  get '/admin/:id', to: 'users#admin'
  delete 'users/:user_id/remove-project/:project_id', to: 'users#remove_project'

  resources :projects, only: [:index, :create, :show, :destroy]
  delete '/projects/clear', to: 'projects#delete_all_complete'
  patch '/project/complete/:id', to: 'projects#complete'
  patch '/add_user/project', to: 'projects#add_new_users'
  get '/download/:id', to: 'projects#download_zip'

  resources :documents, only: [:index, :create]

end
