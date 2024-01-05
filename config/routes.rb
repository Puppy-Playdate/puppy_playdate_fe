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
  get '/users/:id', to: 'users#show'
  get '/users/:id/edit', to: 'users#edit', as: :edit

  # Socials 
  get '/socials', to: 'socials#index', as: :socials  
end
