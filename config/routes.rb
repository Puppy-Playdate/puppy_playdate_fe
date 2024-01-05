Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root 'welcome#index'

  # Users 
  get '/login', to: 'users#login_form'
  post '/login', to: 'users#login_user' 
  get '/register', to: 'users#new', as: :new_user
  # post route for new user
  get '/users/:id', to: 'users#show', as: :user
  get '/users/:id/edit', to: 'users#edit', as: :edit
  patch '/users/:id', to: 'users#edit', as: :update_user

  # Socials 
  get '/socials', to: 'socials#index', as: :socials

  #User_Socials
  get '/users/:id/socials', to: 'user_socials#index', as: :user_socials

  # Dogs 
  get '/users/:id/dogs/new', to: 'dogs#new', as: :add_dog
  # post route for creating a users dog
  get '/users/:id/dogs', to: 'dogs#index', as: :dogs 
end
