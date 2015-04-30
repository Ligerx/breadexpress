BreadExpress::Application.routes.draw do

  get "login", to: 'sessions#new', as: :login
  post "sessions", to: 'sessions#create'
  get "logout", to: 'sessions#destroy', as: :logout
  
  # Routes for main resources
  resources :addresses
  resources :customers
  resources :orders

  
  # Authentication routes



  # Semi-static page routes
  get 'home' => 'home#home', as: :home
  get 'about' => 'home#about', as: :about
  get 'contact' => 'home#contact', as: :contact
  get 'privacy' => 'home#privacy', as: :privacy
  get 'search' => 'home#search', as: :search
  get 'cylon' => 'errors#cylon', as: :cylon
  
  # Set the root url
  root :to => 'home#home'  
  
  # Named routes



  
  # Last route in routes.rb that essentially handles routing errors
  get '*a', to: 'errors#routing'
end
