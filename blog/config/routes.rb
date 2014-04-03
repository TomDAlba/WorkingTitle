Blog::Application.routes.draw do



    namespace :mercury do
      resources :images
    end



  resources :projects

  get "landing/index"

  get "join/index"
  post "join/create"

  get "dashboard/index"

  resources :messages
  resources :roles
  resources :members


  
  get 'projects', to: 'projets#index', as: 'projects'

  resources :projects

  resources :posts do
    collection do
      post :add_image
    end
    resources :user
    collection do
      post :add_like
    end
    member do
      post :preview
    end
  end

  

  devise_for :users do
    resources :posts
  end


  match "beta" => "members#index"
  root :to => 'landing#index'
  mount Mercury::Engine => '/'
end
