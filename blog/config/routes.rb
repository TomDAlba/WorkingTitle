Blog::Application.routes.draw do
  
  # Generate routes to controllers and views

  resources :comments

  get "profiles/show"
  get 'projects/by_prompt', :to => 'projects#by_prompt', :as => 'by_prompt'
  get 'projects/show_by_user', :to => 'projects#show_by_user', :as => 'show_by_user'
  get 'prompts/by_user', :to => 'prompts#by_user', :as => 'by_user'
  
  resources :prompts
  resources :projects do
    member { post :mercury_update }
  end
  post 'projects/:id' => 'projects#update'
  post 'projects/new' => 'projects#create'



  
  get "domains/index"
  get "domains/show"
  resources :roles
  resources :members
  resources :badges
  get "join/index"
  post "join/create"
  

  devise_for :users

  root :to => 'landing#index'
    namespace :mercury do
      resources :images
    end

  mount Mercury::Engine => '/'  


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".


end
