Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root 'welcome#index'
  
  get '/auth/github/callback', to: 'sessions#create'
  #USERS
  resources :users, only: [:show, :create, :edit, :update] do
    resources :dogs, only: [:index, :edit, :update, :new, :create]
    resources :socials, only: [:index, :new, :create, :show]
  end

  get '/register', to: 'users#new', as: :new_user
  get '/login', to: 'users#login_form'
  post '/login', to: 'users#login_user' 
  get "/log_out", to: "users#log_out"
  # get '/users/:id/edit', to: 'users#edit', as: :edit

  #SOCIALS
  get '/socials', to: 'socials#guest_index'

  # get '/users/:id/socials', to: 'user_socials#index', as: :user_socials
  
  # DOGS 
  # get '/users/:id/dogs/new', to: 'dogs#new', as: :add_dog
  # post '/users/:id/dogs', to: 'dogs#create', as: :create_dog
  # get '/users/:id/dogs', to: 'dogs#index', as: :dogs 
  # get '/users/:id/dogs/:dog_id/edit', to: 'dogs#edit', as: :edit_dog
  # patch '/users/:id/dogs/:dog_id', to: 'dogs#update', as: :update_dog
end
