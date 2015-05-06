BreadExpress::Application.routes.draw do

  # Routes for main resources
  resources :addresses
  resources :customers
  resources :orders
  resources :items

  resources :users # Do I need this?

  
  # Authentication routes
  get 'signup', to: 'customers#new', as: :signup
  get "login", to: 'sessions#new', as: :new_login
  post "login", to: 'sessions#create', as: :login
  get "logout", to: 'sessions#destroy', as: :logout


  # Cart routes
  get 'cart', to: 'shopping#cart', as: :cart
  post 'shopping/add_item_to_cart_wrapper', as: :add_item_to_cart
  post 'shopping/update', as: :update_cart
  get 'orders/success', as: :checkout_success


  # Item routes
  get 'bread', to: 'items#index', defaults: { type: 'bread' }, as: :bread
  get 'muffins', to: 'items#index', defaults: { type: 'muffins' }, as: :muffins
  get 'pastries', to: 'items#index', defaults: { type: 'pastries' }, as: :pastries
  get 'admin/items', to: 'items#admin_index', as: :admin_items


  # Extra address routes
  get 'addresses/:id/deactivate', to: 'addresses#deactivate', as: :deactivate_address
  get 'addresses/:id/activate', to: 'addresses#activate', as: :activate_address


  # Admin routes
  get 'dashboard', to: 'home#dashboard', as: :dashboard


  # baking/shipping
  get 'baker', to: 'users#baker', as: :baker
  get 'shipper', to: 'users#shipper', as: :shipper
  post 'shipper', to: 'users#update_order_items', as: :update_order_items


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
