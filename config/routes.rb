Rails.application.routes.draw do
  namespace :api
    namespace :v1

      resources :invites 
      resources :documents, only: [:index, :create]
      resources :archive_documents, only: [:index, :show, :create]
    
      resources :users, only: [:index, :update, :show, :destroy]
      post '/signup', to: 'users#create'
      post '/login', to: 'users#login'
      get '/autologin', to: 'users#autologin'
      delete 'users/:user_id/remove-project/:project_id', to: 'users#remove_project'
    
      resources :archive_projects, only: [:index, :show, :create, :destroy]
      get '/download/:id', to: 'archive_projects#download_zip'
    
      resources :projects, only: [:index, :create, :update, :show, :destroy]
      patch '/add_user/project', to: 'projects#add_users_to_project'

    end
  end
end
