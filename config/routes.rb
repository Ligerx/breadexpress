BreadExpress::Application.routes.draw do

  # Routes for main resources
  resources :addresses
  resources :customers
  resources :orders
  resources :items

  resources :users # Do I need this?

  
  # Authentication routes
  get 'signup', to: 'users#new', as: :signup

  get "login", to: 'sessions#new', as: :new_login
  post "login", to: 'sessions#create', as: :login
  get "logout", to: 'sessions#destroy', as: :logout


  # Cart routes
  get 'cart', to: 'shopping#cart', as: :cart
  post 'shopping/add_item_to_cart_wrapper', as: :add_item_to_cart


  # Item routes
  get 'bread', to: 'items#index', defaults: { type: 'bread' }, as: :bread
  get 'muffins', to: 'items#index', defaults: { type: 'muffins' }, as: :muffins
  get 'pastries', to: 'items#index', defaults: { type: 'pastries' }, as: :pastries


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
